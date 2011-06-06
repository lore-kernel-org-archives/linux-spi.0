From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] spi: reorganize drivers
Date: Mon, 6 Jun 2011 10:38:44 -0600
Message-ID: <BANLkTinmfufSkSnmiKWWEgpaR-usbiV5tA@mail.gmail.com>
References: <20110606071829.10334.90865.stgit@ponder> <BANLkTinqVf+uK+5T_X-EkXw-YE67DJL1Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>,
	Dirk Brandewie <dirk.brandewie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTinqVf+uK+5T_X-EkXw-YE67DJL1Pg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jun 6, 2011 at 10:31 AM, Mike Frysinger <vapier.adi@gmail.com> =
wrote:
> On Mon, Jun 6, 2011 at 03:18, Grant Likely wrote:
>> Sort the SPI makefile and enforce the naming convention spi_*.c for
>> spi drivers.
>
> spi_topcliff_pch.c uses KBUILD_MODNAME with a few funcs, but perhaps
> those are only for /proc/ status tracking ? =A0worth double checking =
=2E..

I just talked with Dirk Brandewie, who has a major rewrite to the
topcliff spi driver.  I'll let him comment on whether or not changing
KBUILD_MODNAME will cause any problems.

g.
