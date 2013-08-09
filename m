From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH] SPI: DUAL and QUAD support
Date: Fri, 9 Aug 2013 04:25:36 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9F22F0@DBDE04.ent.ti.com>
References: <20130729064234.GS9858@sirena.org.uk>
 <1375095194-7093-1-git-send-email-wangyuhang2014@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9EE267@DBDE04.ent.ti.com>
 <CAHSAbzNdvgTSPqDPHT2n3zXFwe7HBqTfyk4fB_-GsW1WSUXqRA@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9EE356@DBDE04.ent.ti.com>
 <CA+7tXijduVqFdao3L3oJcFBYw_cffdyo-fwyAS2cBASfEMExpA@mail.gmail.com>
 <CAHSAbzPjk1M9RzMahYOUkFDJiU8pRWXO2-np0HgQefxEC+WXeA@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9F1E1B@DBDE04.ent.ti.com>,
 <CAHSAbzMOTk-xKDRx-1Ew67OZYbgWQnFCzfjEvu75Wyz6Yb-omA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, "Poddar,
 Sourav" <sourav.poddar@ti.com>, Trent Piepho <tpiepho@gmail.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "broonie@kernel.org" <broonie@kernel.org>
To: yuhang wang <wangyuhang2014@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAHSAbzMOTk-xKDRx-1Ew67OZYbgWQnFCzfjEvu75Wyz6Yb-omA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

> > [Pekon] you need separate DT binding for controller and child devices.
> > And then separate for Tx and Rx in each of them.
> > Also, I suggest you add devicetree-discuss maillist when you update the
> > Device-tree documentation for same.
> >
> Just as you said above, master node describe the total data wires on
> SOC, slave node describe the detailed capability selected, which is
> logically right. But to master, the drivers have already supplied this
> infomation in probe, so do we still need to add in device tree and
> provide another method in master driver to get the info from device
> tree?
> 
[Pekon]: Yes, for controller the controller_driver should parse or fill in
this info in the spi_master->mode.
But, still you need to add check while probing spi_device DT that
only common supported compatibilities get into spi_device.
Example: if spi_master->mode == SPI_TX_DUAL only
and of_spi_device() returns SPI_TX_QUAD, then you should return
back with error showing mis-match in controller and device capabilities.
So, spi_device capabilites should always be sub-set of spi_master capabilities.


> > I havn't seen any traffic on next version of this patch?
> >  Did I miss, or you are working on it?
> >
> No, because of other jobs so didn't fix the patch in time, sorry for
> that. Even now I still in puzzled that whether to make quad in mode or
> add a new member in all the related struct. My trend is the previous
> scheme. However they both have strong and weak points.

> If add in mode:
> [strong points]:
> The existed operation such as compare master mode and device mode, DT
> interface, mode set in master driver and so on which will be a benifit
> to make the quad code clear and smooth.
> [weak points]
> But to expand mode will make spidev not back compatible and the
> modified spidev code to fix the compatible problems looks a little
> wierd.
> Also another point from Trent, to make it consistent between
> spi_transfer and spi_device. just like:
> spi_transfer->speed_hz depend on spi_device->speed_hz;
> spi_transfer->bits_per_word depends on spi_device->bits_per_word;
> So is that add the similar member as below looks better?
> spi_transfer->tx_nbits depends on spi_device->tx_nbits not spi_device->mode.

> if add new member:
> The previous strong points and weak points will become exchanged.

> I still hope some suggestions to make one scheme extremely powerful
> and I will provide the patch this week.

[Pekon]: I'm also inclined to your suggestion of previous scheme,
but we don't break the binary compatibility with userspace applications.
(as Matt pointed out earlier). But I think its more of an upgrade|extension of
of IOCTL than re-defining it. And as SPI is evolving we need to make these
upgrades in our interface to adapt to newer SPI.
But its upto maintainers to accept that. So, I suggest you send the spidev
related patch separately, so that there could be more discussion on that.


with regards, pekon
______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
