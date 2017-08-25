From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
        <alexander.haenel-baas-2YRSn766l8rddJNmlsFzeA@public.gmane.org>
Subject: SPI_IOC_WR_MAX_SPEED_HZ was overwitten?
Date: Fri, 25 Aug 2017 09:08:36 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC9123656326C4@SMExchange01.siebmeyer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
To: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: de-DE
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi

Is it possible that the ioctl SPI_IOC_WR_MODE call can overwrite the previous ioctl SPI_IOC_WR_MAX_SPEED_HZ speed setting?

When  we call ioctl(fd, SPI_IOC_WR_MAX_SPEED_HZ, &speed_hz) and then ioctl(fd, SPI_IOC_WR_MODE, &mode) the spi speed is taken from dts.

The spi_dev shows:
[ 4184.702224] spidev spi0.0: setup mode 0, 8 bits/w, 1000000 Hz max --> 0     SPI_IOC_WR_MAX_SPEED_HZ call, set 1MHz
[ 4184.702252] spidev spi0.0: setup mode 3, 8 bits/w, 20000000 Hz max --> 0    SPI_IOC_WR_MODE call set mode 3 but use the default speed from devicetree

And now the spi speed is wrong and cannot be used.

When we change the order to:
ioctl(fd, SPI_IOC_WR_MODE, &mode) and then
ioctl(fd, SPI_IOC_WR_MAX_SPEED_HZ, &speed_hz)

The spi_dev shows:
[10711.100375] spidev spi0.0: setup mode 3, 8 bits/w, 20000000 Hz max --> 0  SPI_IOC_WR_MODE call set mode 3
[10711.100400] spidev spi0.0: setup mode 3, 8 bits/w, 1000000 Hz max --> 0    SPI_IOC_WR_MAX_SPEED_HZ call, set 1MHz

And now the spi speed is right and can be used.

We need to program the Spansion flash chip "S25FL064A/P" with the spi interface from the QoriQ LS1021a.
The linux version is: 4.4.26.

I hope we can clarify this.

Thanks,
Alexander
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
