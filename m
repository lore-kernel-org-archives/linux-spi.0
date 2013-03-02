From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: Initialize cs_gpio and cs_gpios with -ENOENT
Date: Sat, 02 Mar 2013 22:46:47 +0000
Message-ID: <20130302224647.7D72C3E2F21@localhost>
References: <1360761625-15562-1-git-send-email-andreas@gaisler.com>
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	software@gaisler.com
To: Andreas Larsson <andreas@gaisler.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360761625-15562-1-git-send-email-andreas@gaisler.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 13 Feb 2013 14:20:25 +0100, Andreas Larsson <andreas@gaisler.com> wrote:
> The return value from of_get_named_gpio is -ENOENT when the given index
> matches a hole in the "cs-gpios" property phandle list. However, the
> default value of cs_gpio in struct spi_device and entries of cs_gpios in
> struct spi_master is -EINVAL, which is documented to indicate that a
> GPIO line should not be used for the given spi_device.
> 
> This sets the default value of cs_gpio in struct spi_device and entries
> of cs_gpios in struct spi_master to -ENOENT. Thus, -ENOENT is the only
> value used to indicate that no GPIO line should be used.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Applied, thanks.
g.
