From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] spi: Remove SPI_BUFSIZ restriction on
 spi_write_then_read()
Date: Thu, 6 Dec 2012 14:37:33 +0900
Message-ID: <20121206053732.GD10867@opensource.wolfsonmicro.com>
References: <1354420465-29315-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20121206000026.A620D3E0E22@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121206000026.A620D3E0E22@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Dec 06, 2012 at 12:00:26AM +0000, Grant Likely wrote:

> Looks good to me. Probably 3.9 material though.

> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Hrm, I'd be inclined to apply it now - it's isolated enough that it can
be reverted if it explodes and we have the -rc cycle to notice any
problems.
