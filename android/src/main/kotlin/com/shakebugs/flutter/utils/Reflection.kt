package com.shakebugs.flutter.utils

import java.lang.reflect.Method

fun getMethod(clazz: Class<*>, methodName: String?, vararg parameterType: Class<*>): Method? {
    val methods: Array<Method> = clazz.declaredMethods
    for (method in methods) {
        if (method.name == methodName && method.parameterTypes.size ==
                parameterType.size) {
            if (parameterType.isEmpty()) {
                method.isAccessible = true
                return method
            }
            for (i in parameterType.indices) {
                if (method.parameterTypes[i] === parameterType[i]) {
                    if (i == method.parameterTypes.size - 1) {
                        method.isAccessible = true
                        return method
                    }
                } else {
                    break
                }
            }
        }
    }
    return null
}


//public static Method getMethod(Class clazz, String methodName, Class... parameterType) {
//    final Method[] methods = clazz.getDeclaredMethods();
//
//    for (Method method : methods) {
//        if (method.getName().equals(methodName) && method.getParameterTypes().length ==
//                parameterType.length) {
//            if (parameterType.length == 0) {
//                method.setAccessible(true);
//                return method;
//            }
//            for (int i = 0; i < parameterType.length; i++) {
//                if (method.getParameterTypes()[i] == parameterType[i]) {
//                    if (i == method.getParameterTypes().length - 1) {
//                        method.setAccessible(true);
//                        return method;
//                    }
//                } else {
//                    break;
//                }
//            }
//        }
//    }
//    return null;
//}