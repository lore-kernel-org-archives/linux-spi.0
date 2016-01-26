From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/4] spi: pxa2xx: Translate ACPI DeviceSelection to Linux
 chip select on Baytrail
Date: Tue, 26 Jan 2016 15:27:52 +0200
Message-ID: <20160126132752.GA30165@lahna.fi.intel.com>
References: <1453807111-103111-1-git-send-email-mika.westerberg@linux.intel.com>
 <1453807111-103111-3-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Bastien Nocera <bugzilla@hadess.net>,
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453807111-103111-3-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 26, 2016 at 01:18:29PM +0200, Mika Westerberg wrote:
>  #else /* !CONFIG_ACPI */
>  static int pxa2xx_spi_get_port_id(struct acpi_device *adev)
>  {
>  	return -1;
>  }
> +#define pxa2xx_spi_fw_translate_cs	NULL

I need to move this elsewhere because it is still guarded by CONFIG_PCI
as pointed out by kbuild robot.

Will do that in next revision.
