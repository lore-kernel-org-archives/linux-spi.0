From: yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] SPI: DUAL and QUAD support
Date: Fri, 9 Aug 2013 17:14:25 +0800
Message-ID: <CAHSAbzO-dJSboJX-4g9mUcjRicoT_XwD=h1h-=MD5tvRGv72Wg@mail.gmail.com>
References: <20130729064234.GS9858@sirena.org.uk>
	<1375095194-7093-1-git-send-email-wangyuhang2014@gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9EE267@DBDE04.ent.ti.com>
	<CAHSAbzNdvgTSPqDPHT2n3zXFwe7HBqTfyk4fB_-GsW1WSUXqRA@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9EE356@DBDE04.ent.ti.com>
	<CA+7tXijduVqFdao3L3oJcFBYw_cffdyo-fwyAS2cBASfEMExpA@mail.gmail.com>
	<CAHSAbzPjk1M9RzMahYOUkFDJiU8pRWXO2-np0HgQefxEC+WXeA@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9F1E1B@DBDE04.ent.ti.com>
	<CAHSAbzMOTk-xKDRx-1Ew67OZYbgWQnFCzfjEvu75Wyz6Yb-omA@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9F22F0@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Poddar,
	Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>, Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9F22F0-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi, Pekon

2013/8/9 Gupta, Pekon <pekon-l0cyMroinI0@public.gmane.org>:
>> 2. I don't think that  SPI_NBITS_SINGLE_HALF_DUPLEX is necessary.
>> tx_nbits and rx_nbits in @spi_transfer should be passed to spi master
>> driver and the master driver will set the certain mode depend on the
>> info in @spi_transfer. So there is no need to let the master driver
>> know SPI_NBITS_SINGLE_HALF_DUPLEX, also master can get the 3-wire SPI
>> info from spi_device->mode.
> I should have been more explicit here.. it would be good it you replace
> 'spi_device->mode & SPI_3_WIRE' with your above mode & tx_nbit, rx_nbits
> so that the channel width information becomes consistent for all modes.
> All mode bit flags in same octet look better.
>
If still use mode in spi_master and spi_device, I don't think it is
possible to del SPI_3_WIRE. But we should make sure if SPI_3_WIRE is
selected by slave, then dual and quad should not be set again.

2013/8/9 Gupta, Pekon <pekon-l0cyMroinI0@public.gmane.org>:
>> > [Pekon] you need separate DT binding for controller and child devices.
>> > And then separate for Tx and Rx in each of them.
>> > Also, I suggest you add devicetree-discuss maillist when you update the
>> > Device-tree documentation for same.
>> >
>> Just as you said above, master node describe the total data wires on
>> SOC, slave node describe the detailed capability selected, which is
>> logically right. But to master, the drivers have already supplied this
>> infomation in probe, so do we still need to add in device tree and
>> provide another method in master driver to get the info from device
>> tree?
>>
> [Pekon]: Yes, for controller the controller_driver should parse or fill in
> this info in the spi_master->mode.
> But, still you need to add check while probing spi_device DT that
> only common supported compatibilities get into spi_device.
> Example: if spi_master->mode == SPI_TX_DUAL only
> and of_spi_device() returns SPI_TX_QUAD, then you should return
> back with error showing mis-match in controller and device capabilities.
> So, spi_device capabilites should always be sub-set of spi_master capabilities.
>
Yes, it is necessary to check. But I don't think it is a good way to
fill in spi_master->mode from master node of DT. Master driver
developer should set dual or quad mode in spi_master->mode directly
just like SPI_CPHA and SPI_CPOL. To keep consistent, dual and quad
should also not appear in master node.

>> > I havn't seen any traffic on next version of this patch?
>> >  Did I miss, or you are working on it?
>> >
>> No, because of other jobs so didn't fix the patch in time, sorry for
>> that. Even now I still in puzzled that whether to make quad in mode or
>> add a new member in all the related struct. My trend is the previous
>> scheme. However they both have strong and weak points.
>
>> If add in mode:
>> [strong points]:
>> The existed operation such as compare master mode and device mode, DT
>> interface, mode set in master driver and so on which will be a benifit
>> to make the quad code clear and smooth.
>> [weak points]
>> But to expand mode will make spidev not back compatible and the
>> modified spidev code to fix the compatible problems looks a little
>> wierd.
>> Also another point from Trent, to make it consistent between
>> spi_transfer and spi_device. just like:
>> spi_transfer->speed_hz depend on spi_device->speed_hz;
>> spi_transfer->bits_per_word depends on spi_device->bits_per_word;
>> So is that add the similar member as below looks better?
>> spi_transfer->tx_nbits depends on spi_device->tx_nbits not spi_device->mode.
>
>> if add new member:
>> The previous strong points and weak points will become exchanged.
>
>> I still hope some suggestions to make one scheme extremely powerful
>> and I will provide the patch this week.
>
> [Pekon]: I'm also inclined to your suggestion of previous scheme,
> but we don't break the binary compatibility with userspace applications.
> (as Matt pointed out earlier). But I think its more of an upgrade|extension of
> of IOCTL than re-defining it. And as SPI is evolving we need to make these
> upgrades in our interface to adapt to newer SPI.
> But its upto maintainers to accept that. So, I suggest you send the spidev
> related patch separately, so that there could be more discussion on that.
>
>
OK, I will separate the patch. Thanks.

Best regards

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
