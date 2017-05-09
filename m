From: Seraphime Kirkovski <kirkseraph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] spi: spidev: Introduce SPI_IOC_WR_DEFAULT_MAX_SPEED_HZ command
Date: Tue,  9 May 2017 14:23:59 +0200
Message-ID: <20170509122401.2561-1-kirkseraph@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        Seraphime Kirkovski <kirkseraph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Historically SPI_IOC_WR_MAX_SPEED_HZ was changing the ->max_speed_hz field
of the underlying struct spi_dev, which made the effects last way after
releasing one particular /dev/spidev* fd.

This changed in 9169051617df7 ("spi: spidev: Don't mangle max_speed_hz
in underlying spi device") or 7 years after the introduction of
SPI_IOC_WR_MAX_SPEED_HZ ! In the mean time there were userspace tools
developped with the assumptions that the effects of this particular
command are system-wide. [1] is a suite of two small programs for
reading, writing and configuring SPI interfaces. The `spi-config -s`
part was working good in our setup with old 3.x kernels. We discovered
this "regression" when we tried to port our workflow to newer kernels.

I think, this change is necessary, on the one hand, because there are still
a lot of longterm[2] supported kernels out there, whose users may be relying on
SPI_IOC_WR_MAX_SPEED being system-wide and, on the other hand, this
same command has been exhibiting a different behaviour for 3 years now,
so its users may break, if 9169051617df7 is reverted in one way or
another.

The semantics of the proposed command are the same as the old
SPI_IOC_WR_MAX_SPEED_HZ.

[1] https://github.com/cpb-/spi-tools
[2] A quick check on kernel.org shows that all 3.x with longterm support
    have not applied 9169051617df7

Seraphime Kirkovski (2):
  spi: spidev: introduce SPI_IOC_WR_DEFAULT_MAX_SPEED_HZ command
  spi: spidev: document SPI_IOC_WR_DEFAULT_MAX_SPEED_HZ

 Documentation/spi/spidev        | 7 +++++++
 drivers/spi/spidev.c            | 8 ++++++--
 include/uapi/linux/spi/spidev.h | 4 +++-
 3 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.13.0.rc1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
