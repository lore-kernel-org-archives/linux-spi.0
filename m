From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 1/2] spi: add support for DLN-2 USB-SPI adapter
Date: Fri, 28 Nov 2014 16:57:04 +0200
Message-ID: <20141128145703.GA16201@lpalcu-linux>
References: <1416312599-5176-2-git-send-email-laurentiu.palcu@intel.com>
 <1417180198-9393-1-git-send-email-laurentiu.palcu@intel.com>
 <20141128141053.GL7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Johan Havold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141128141053.GL7712-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Fri, Nov 28, 2014 at 02:10:53PM +0000, Mark Brown wrote:
> On Fri, Nov 28, 2014 at 03:09:58PM +0200, Laurentiu Palcu wrote:
> > This adds support for Diolan DLN2 USB-SPI adapter.
> 
> I'm missing patch 2 of this series and the cover letter, are there any
> dependencies.

The other patch in this series was already applied by Lee on
for-mfd-next branch:
http://git.kernel.org/cgit/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=21cf3318d675b6ceeb5a3ed82ffe467a2b6eaee4

The original dependency, 3 patches that implement the DLN2 mfd driver
and the I2C/GPIO module drivers, is also in for-mfd-next:
http://git.kernel.org/cgit/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=338a128142975439a19ab3c91480bc9d5a71f033

laurentiu
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
