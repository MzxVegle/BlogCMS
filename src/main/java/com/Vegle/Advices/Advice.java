package com.Vegle.Advices;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class Advice {
    private Logger logger = LogManager.getLogger(this);
    @Pointcut(value = "execution(* com.Vegle.Services.*.*.*(..))")
    private void services(){}
    @Around("services()")
    public Object runTime(ProceedingJoinPoint pjp)throws Throwable{

        long before = System.currentTimeMillis();
        Object proceed = pjp.proceed();
        long after = System.currentTimeMillis();

        logger.info("耗时:"+(after-before)+"ms");
        return proceed;
    }

}
