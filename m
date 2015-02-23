From: =?UTF-8?Q?aur=C3=A9lien_bouin?= <a.bouin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: imx: Chose DMA bits per word transfered
Date: Mon, 23 Feb 2015 09:44:50 +0100
Message-ID: <CAFeThoDBstQ_=gsi2o509qqQR6PbV4MxsNe=hEhKj4Mj162osA@mail.gmail.com>
References: <1423742848-15369-1-git-send-email-a.bouin@gmail.com>
	<1423742848-15369-3-git-send-email-a.bouin@gmail.com>
	<20150221143528.GU6236@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150221143528.GU6236-bheZrs9scGb3/WHNxyQH9YN0K6Il/+VY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

At the moment there is no possibility to change the dma bits per word use ...
It is an easy way to be able to do so.
Feel free to propose something better

2015-02-21 15:35 GMT+01:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Thu, Feb 12, 2015 at 01:07:27PM +0100, Aurelien BOUIN wrote:
>> This patch enable to give a parameter to device tree to set the number of bits per word the DMA uses in transfer
>> In device tree you can specify fsl,spi-dma-bits-per-word = <16>; in the ecspi section
>
> Why would this be a DT property?  It seems like something the driver
> ought to be able to figure out automatically if it matters.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
