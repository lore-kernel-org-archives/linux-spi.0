From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] spi: Fix comparison of different integer types
Date: Fri, 7 Dec 2012 12:48:06 +0900
Message-ID: <20121207034804.GC26070@opensource.wolfsonmicro.com>
References: <1354836947-31078-1-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1354836947-31078-1-git-send-email-grant.likely@secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Dec 06, 2012 at 11:35:47PM +0000, Grant Likely wrote:
> Fix problem discovered with sparse:
> + drivers/spi/spi.c:1554:37: sparse: incompatible types in comparison expression (different signedness)
> drivers/spi/spi.c: In function 'spi_write_then_read':
> drivers/spi/spi.c:1554:23: warning: comparison of distinct pointer types lacks a cast [enabled by default]
> 
> The change to SPI_BUFSIZ was introduced in commit b3a223ee2, "spi:
> Remove SPI_BUFSIZ restriction on spi_write_then_read()"

Thanks.
