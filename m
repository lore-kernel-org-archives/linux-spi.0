From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v2] spi: reorganize drivers
Date: Mon, 6 Jun 2011 12:31:12 -0400
Message-ID: <BANLkTinqVf+uK+5T_X-EkXw-YE67DJL1Pg@mail.gmail.com>
References: <20110606071829.10334.90865.stgit@ponder>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110606071829.10334.90865.stgit@ponder>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jun 6, 2011 at 03:18, Grant Likely wrote:
> Sort the SPI makefile and enforce the naming convention spi_*.c for
> spi drivers.

spi_topcliff_pch.c uses KBUILD_MODNAME with a few funcs, but perhaps
those are only for /proc/ status tracking ?  worth double checking ...
-mike
