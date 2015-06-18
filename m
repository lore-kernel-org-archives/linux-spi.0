From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: expose spi_master and spi_device statistics via sysfs
Date: Thu, 18 Jun 2015 14:54:35 +0200
Message-ID: <B3BA7701-96E1-466A-90EA-121E2A85F851@martin.sperl.org>
References: <1432574909-2326-1-git-send-email-kernel@martin.sperl.org> <556EE446.3060407@metafoo.de> <20150603115319.GF14071@sirena.org.uk> <8DBE5E2D-47ED-48D3-A185-82AF4831B0A2@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8DBE5E2D-47ED-48D3-A185-82AF4831B0A2-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 04.06.2015, at 18:56, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
>> We do get to control the permissions on sysfs files, though it's a bit
>> more unusual to make things root only (and there is the histogram).
> 
> I left histogram as a single file because I remember having seen a file in
> /sys with similar semantics using multiple values (but I can not
> remember which one).

Now that I am back here some examples from /sys which contain multiple values:
/sys/devices/platform/soc/20980000.usb/pools:
poolinfo - 0.1
buffer-2048         0    0 2048  0
buffer-512          0    0  512  0
buffer-128          1   32  128  1
buffer-32           0    0   32  0

/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:0/block/sda/sda1/stat:
/sys/devices/platform/soc/20300000.sdhci/mmc_host/mmc0/mmc0:e624/block/mmcblk0/mmcblk0p1/stat:
     425       56     3842      670        7        9      128     2080        0     1530     2750

/sys/kernel/vmcoreinfo:
85d84c 1024

/sys/devices/platform/soc/20300000.sdhci/mmc_host/mmc0/mmc0:e624/block/mmcblk0/inflight:
/sys/devices/platform/soc/20980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:0/block/sda/sda1/inflight:
       0        0

So it is rare, but not totally uncommon - especially those block statistics.

I can still remove the histogram or move it to separate files per bin
(similar to /sys/kernel/slab/:t-*)

What would you prefer so that I can fix the patch?--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
