package io.report.common.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

/**
 *         CommandLineRunner跟ApplicationRunner一样的功能
 */
@Component
public class CommandLineRunnerImpl implements CommandLineRunner {

    /**
     * 会在服务启动完成后立即执行
     */
    @Override
    public void run(String... args) throws Exception {
        System.out.println("*********************************************项目启动完成************************************************");
    }
}
