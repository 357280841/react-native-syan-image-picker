package com.syanpicker;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.Rect;
import android.media.ExifInterface;
import android.os.Environment;
import android.text.TextUtils;
import android.util.TypedValue;

import com.bumptech.glide.Glide;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

public class WaterMarkerUtils {
    public static String processPic(String path, WaterMarkConfig waterMarkConfig, Activity activity) {
        try {
            File file = new File(path);
            if (file.exists()) {
                Bitmap bitmap = getScaledBitmap(activity, path, waterMarkConfig.isCompression);
                Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
                paint.setAntiAlias(true);

                Bitmap.Config bitmapConfig = bitmap.getConfig();

//        paint.setDither(true); // 获取跟清晰的图像采样
//        paint.setFilterBitmap(true);// 过滤一些
                if (bitmapConfig == null) {
                    bitmapConfig = Bitmap.Config.RGB_565;
                }
                Bitmap newBitmap = bitmap.copy(bitmapConfig, true);
                Canvas canvas = new Canvas(newBitmap);

                int height = canvas.getHeight();
                int width = canvas.getWidth();
                List<WaterMarkConfig.TitlesBean> titlesBeans = waterMarkConfig.titles;
                if (titlesBeans != null && !titlesBeans.isEmpty()) {
                    for (WaterMarkConfig.TitlesBean t : titlesBeans) {
                        String color = "#FFFFFF";

                        if (!isNullOrEmpty(t.color)) {
                            if (!t.color.startsWith("#")) {
                                color = "#" + t.color;
                            } else {
                                color = t.color;
                            }
                        }
                        paint.setColor(Color.parseColor(color));

                        int textw = Integer.MAX_VALUE;
                        int font = t.font == 0 ? 16 : t.font;
                        Rect rect = new Rect();
                        do{
                            paint.setTextSize(TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_SP,font, activity.getResources().getDisplayMetrics()));
                            paint.getTextBounds(t.text, 0, t.text.length(), rect);
                            textw = rect.width();
                            font--;
                        }while (textw + t.x > width);
                        int texth = rect.height();

                        float x = 0, y = 0;
                        if (t.centerX == 1 && t.centerY == 1) {
                            x = (width - textw) / 2;
                            y = (height - texth) / 2;
                        } else if (t.centerX == 1 && t.centerY != 1) {
                            x = (width - textw) / 2;
                            y = t.y;
                        } else if (t.centerX != 1 && t.centerY == 1) {
                            x = t.x;
                            y = (height - texth) / 2;
                        } else if (t.centerX != 1 && t.centerY != 1) {
                            //0,//坐标原点, 0:左上角, 1:右上角, 2:右下角, 3左下角
                            if (t.position == 0) {
                                x = t.x;
                                y = t.y + texth;
                            } else if (t.position == 1) {
                                x = width - t.x - textw;
                                y = t.y + texth;
                            } else if (t.position == 2) {
                                x = width - t.x - textw;
                                y = height - t.y;
                            } else if (t.position == 3) {
                                x = t.x;
                                y = height - t.y;
                            }
                        }
                        canvas.drawText(t.text, x, y, paint);
                    }
                }

                List<WaterMarkConfig.ImagesBean> imagesBeans = waterMarkConfig.images;
                if (imagesBeans != null && !imagesBeans.isEmpty()) {
                    for (WaterMarkConfig.ImagesBean img : imagesBeans) {
                        int imgh = 120, imgw = 120;
                        if (img.h > 0) imgh = img.h;
                        if (img.w > 0) imgw = img.w;
                        Bitmap b = null;
//                        if ("AppIcon".equalsIgnoreCase(img.type)) {
//                            b = BitmapFactory.decodeResource(activity.getResources(), com.vplus.R.drawable.ic_launcher);
//                        } else {
//                            if (!TextUtils.isEmpty(img.url)) {
//                                b = ImageLoaderUtils.loadUrlGetBitmap(cordova.getActivity(), img.url, imgh, imgw);
//                            }
//                        }
                        if (!TextUtils.isEmpty(img.url)) {
                            b = loadUrlGetBitmap(activity, img.url, imgh, imgw);
                        }
                        if (b != null) {
                            float x = 0, y = 0;
                            if (img.centerX == 1 && img.centerY == 1) {
                                x = (width - imgw) / 2;
                                y = (height - imgh) / 2;
                            } else if (img.centerX == 1 && img.centerY != 1) {
                                x = (width - imgw) / 2;
                                y = img.y;
                            } else if (img.centerX != 1 && img.centerY == 1) {
                                x = img.x;
                                y = (height - imgh) / 2;
                            } else if (img.centerX != 1 && img.centerY != 1) {
                                //0,//坐标原点, 0:左上角, 1:右上角, 2:右下角, 3左下角
                                if (img.position == 0) {
                                    x = img.x;
                                    y = img.y;
                                } else if (img.position == 1) {
                                    x = width - img.x - imgw;
                                    y = img.y;
                                } else if (img.position == 2) {
                                    x = width - img.x - imgw;
                                    y = height - img.y - imgh;
                                } else if (img.position == 3) {
                                    x = img.x;
                                    y = height - img.y - imgh;
                                }
                            }
                            /**
                             * canvas.drawBitmap要用react才能设定图片大小
                             */
                            int left = (int)x;
                            int top = (int)y;
                            int right = left + imgw;
                            int bottom = top + imgh;

//                            canvas.drawBitmap(b, x, y, paint);
                            Rect rect = new Rect(left,top,right,bottom);
                            canvas.drawBitmap(b, null, rect, paint);
//                            canvas.drawBitmap(b, null, new Rect(0,0,imgw,imgh), paint);
                        }
                    }
                }


//                File filePic = new File(FilePathConstants.APP_IMAGE_CACHE_PATH, UUID.randomUUID().toString() + file.getName());
                File filePic = new File(activity.getFilesDir().getPath(), UUID.randomUUID().toString() + file.getName());
                if (!filePic.exists()) {
                    filePic.getParentFile().mkdirs();
                    filePic.createNewFile();
                }
                FileOutputStream fos = new FileOutputStream(filePic);
                newBitmap.compress(Bitmap.CompressFormat.JPEG, 70, fos);
                fos.flush();
                fos.close();
                if (!bitmap.isRecycled()) {
                    bitmap.recycle();
                }
                if (!newBitmap.isRecycled()) {
                    newBitmap.recycle();
                }
                return filePic.getAbsolutePath();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //指定最大宽度，按照比例缩小高度
    public static Bitmap getScaledBitmap(Context context, String filePath, float maxWidth) {
        if (isNullOrEmpty(filePath) && !new File(filePath).exists()) {
            return null;
        }
        File mFile = new File(filePath);
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        Bitmap bmp = null;
        if (mFile.exists()) {
            bmp = BitmapFactory.decodeFile(filePath, options);
        }

        int actualHeight = options.outHeight;
        int actualWidth = options.outWidth;

        if (actualWidth < 0 || actualHeight < 0) {
            Bitmap bitmap2 = BitmapFactory.decodeFile(filePath);
            if (bitmap2 != null) {
                actualWidth = bitmap2.getWidth();
                actualHeight = bitmap2.getHeight();
            }
        }

        float imgRatio = (float) actualWidth / actualHeight;
        float maxRatio = actualWidth / actualHeight;

        // width and height values are set maintaining the aspect ratio of the
        // image
        if (actualWidth > maxWidth) {
            actualHeight = (int) (maxWidth / actualWidth * actualHeight);
            actualWidth = (int) maxWidth;
        }

        // setting inSampleSize value allows to load a scaled down version of
        // the original image
//        BitmapFactory.Options options1=
        BitmapFactory.Options options1 = new BitmapFactory.Options();
        options1.inSampleSize = calculateInSampleSize(options, actualWidth, actualHeight);

        // inJustDecodeBounds set to false to load the actual bitmap
        options1.inJustDecodeBounds = false;

        // this options allow android to claim the bitmap memory if it runs low
        // on memory
        options1.inPurgeable = true;
        options1.inInputShareable = true;
        options1.inTempStorage = new byte[16 * 1024];
        try {
            // load the bitmap from its path
            bmp = BitmapFactory.decodeFile(filePath, options1);
            if (bmp == null) {
                InputStream inputStream = null;
                try {
                    inputStream = new FileInputStream(filePath);
                    bmp = BitmapFactory.decodeStream(inputStream, null, options);
                    inputStream.close();
                    return bmp;
                } catch (Exception exception) {
                    exception.printStackTrace();
                }
            }

        } catch (OutOfMemoryError exception) {
            exception.printStackTrace();
        }
//        return bmp;
        Bitmap scaledBitmap = null;
        try {
            scaledBitmap = Bitmap.createBitmap(actualWidth, actualHeight, Bitmap.Config.RGB_565);
        } catch (OutOfMemoryError exception) {
            exception.printStackTrace();
        }

//        if(scaledBitmap!=null){
//            return scaledBitmap;
//        }

        float ratioX = actualWidth / (float) options1.outWidth;
        float ratioY = actualHeight / (float) options1.outHeight;

        Matrix scaleMatrix = new Matrix();
        scaleMatrix.setScale(ratioX, ratioY, 0, 0);

        Canvas canvas = new Canvas(scaledBitmap);
        canvas.setMatrix(scaleMatrix);
        canvas.drawBitmap(bmp, 0, 0, new Paint(Paint.FILTER_BITMAP_FLAG));

        // check the rotation of the image and display it properly
        ExifInterface exif;
        try {
            exif = new ExifInterface(filePath);
            int orientation = exif.getAttributeInt(ExifInterface.TAG_ORIENTATION, 0);
            Matrix matrix = new Matrix();
            if (orientation == 6) {
                matrix.postRotate(90);
            } else if (orientation == 3) {
                matrix.postRotate(180);
            } else if (orientation == 8) {
                matrix.postRotate(270);
            }
            scaledBitmap = Bitmap.createBitmap(scaledBitmap, 0, 0, scaledBitmap.getWidth(), scaledBitmap.getHeight(),
                    matrix, true);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return scaledBitmap;
    }

    private static int calculateInSampleSize(BitmapFactory.Options options, int reqWidth, int reqHeight) {
        final int height = options.outHeight;
        final int width = options.outWidth;
        int inSampleSize = 1;

        if (height > reqHeight || width > reqWidth) {
            final int heightRatio = Math.round((float) height / (float) reqHeight);
            final int widthRatio = Math.round((float) width / (float) reqWidth);
            inSampleSize = heightRatio < widthRatio ? heightRatio : widthRatio;
        }

        final float totalPixels = width * height;
        final float totalReqPixelsCap = reqWidth * reqHeight * 2;

        while (totalPixels / (inSampleSize * inSampleSize) > totalReqPixelsCap) {
            inSampleSize++;
        }

        return inSampleSize;
    }

    public static boolean isNullOrEmpty(String tk) {
        return tk == null || tk.trim().length() == 0;
    }

    public static Bitmap loadUrlGetBitmap(Context con, String url,int width,int heght) {
        Bitmap bitmap=null;
        try{
            bitmap= Glide.with(con).asBitmap().load(url).submit(width, heght)
                    .get();
        }catch (Exception e){
            e.printStackTrace();
        }
        return bitmap;
    }
}
