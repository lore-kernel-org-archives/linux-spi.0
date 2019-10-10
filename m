From: Yizhuo Zhai <yzhai003@ucr.edu>
Subject: Potential NULL pointer deference in spi
Date: Wed, 9 Oct 2019 22:37:04 -0700
Message-ID: <CABvMjLToYzmCue-TiDhR4Yu4v3+Z+-UV9WhixV7uvwoMh2m5Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi All:

drivers/spi/spi.c:

The function to_spi_device() could return NULL, but some callers
in this file does not check the return value while directly dereference
it, which seems potentially unsafe.

Such callers include spidev_release(),  spi_dev_check(),
driver_override_store(), etc.


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
