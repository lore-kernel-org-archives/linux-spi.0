From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/4] ACPI: fix create_modalias() return value handling
Date: Wed, 15 Jan 2014 17:02:45 +0200
Message-ID: <20140115150245.GW2494@intel.com>
References: <1389689198-2641-1-git-send-email-rui.zhang@intel.com>
 <1389689198-2641-2-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org,
	rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389689198-2641-2-git-send-email-rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 14, 2014 at 04:46:35PM +0800, Zhang Rui wrote:
> Currently, create_modalias() handles the output truncated case in
> an improper way (return -EINVAL).
> Plus, acpi_device_uevent() and acpi_device_modalias_show() do
> improper check for the create_modalias() return value as well.
> 
> This patch fixes create_modalias() to
> return -EINVAL if there is an output error,
> return -ENOMEM if the output is truncated,
> and also fixes both acpi_device_uevent() and acpi_device_modalias_show()
> to do proper return value check.
> 
> Signed-off-by: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
