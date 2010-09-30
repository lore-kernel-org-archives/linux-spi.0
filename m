From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v3 6/7] mtd: m25p80: add a read function to read page by
	page
Date: Thu, 30 Sep 2010 03:46:25 -0700 (PDT)
Message-ID: <841976.76219.qm@web180306.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: kumar.gala@freescale.com, Mingkai Hu <Mingkai.hu@freescale.com>
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-mtd@lists.infradead.org, Mingkai Hu <Mingkai.hu@freescale.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org


--- On Thu, 9/30/10, Mingkai Hu <Mingkai.hu@freescale.com> wrote:

> From: Mingkai Hu <Mingkai.hu@freescale.com>
> Subject: [PATCH v3 6/7] mtd: m25p80: add a read function to read page by =
page

NAK.

We went over this before.

=A0 The bug is in your SPI master controller driver,
and the fix there involves mapping large reads
 into multiple smaller reads.=A0 (Example, 128K
read as two 64K reads instead of one of 128K.

It's *NEVER* appropriate to commit to patching all
upper level drivers in order to work around bugs
in lower level ones.=A0 The set of such upper level
drivers that may need bugfixing is quite large,
most will never be used with your buggy controller
driver, and all such patches will need testing (but
the test resources are probably not available).

Whatever SPI controller driver you're working with
is clearly buggy ... but not unfixably so.

DO NOT head down the path of requiring every SPI
device driver to include workarounds for this odd
little SPI master driver bug.

- Dave
