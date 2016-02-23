From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4] spi: master driver to enable RTC on ICPDAS LP-8841
Date: Tue, 23 Feb 2016 17:28:21 -0600
Message-ID: <20160223232821.GA14960@rob-hp-laptop>
References: <1456105630-28914-1-git-send-email-ynvich@gmail.com>
 <1456224272-4391-1-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456224272-4391-1-git-send-email-ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Feb 23, 2016 at 01:44:28PM +0300, Sergei Ianovich wrote:
> ICP DAS LP-8841 contains a DS-1302 RTC. This driver provides an SPI
> master which makes the RTC usable. The driver is not supposed to work
> with anything else.
> 
> The driver uses the standard MicroWire half-duplex transfer timing.
> Master output is set on low clock and sensed by the RTC on the rising
> edge. Master input is set by the RTC on the trailing edge and is sensed
> by the master on low clock.
> 
> Signed-off-by: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> 
>    v3..v4
>    fix Mark Brown review comments
>    * fix dependencies in Kconfig
> 
>    fix Rob Herring review comments
>    * rewrite binding description
>    * change binding and doc file names
>    * fix typo
> 
>    v2..v3 to fix Mark Brown review comments
>    * drop dependencies in Kconfig
>    * use #ifdef CONFIG_OF to allow build without DT
>    * drop empty driver->remove
> 
>    v1..v2 to fix Mark Brown review comments
>    * drop ifdef around MODULE_NAME
>    * use usleep_range directly
>    * drop empty master->cleanup
> ---
>  .../bindings/spi/icpdas-lp8841-spi-rtc.txt         |  54 +++++

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
