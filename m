From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH v2 4/6] mtd: m25p80: add a read
	function to read page by page
Date: Tue, 10 Aug 2010 06:44:03 -0700 (PDT)
Message-ID: <220473.37389.qm@web180310.mail.gq1.yahoo.com>
References: <AANLkTikM5je7Ckt=7bP6fj7OKCaroSn_AqgcS4T+Bv5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	spi-devel-general@lists.sourceforge.net
To: Mingkai Hu <Mingkai.hu@freescale.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <AANLkTikM5je7Ckt=7bP6fj7OKCaroSn_AqgcS4T+Bv5d@mail.gmail.com>
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



--- On Tue, 8/10/10, Grant Likely <grant.likely@secretlab.ca> wrote:

> This one bothers me, but I can't put my
> finger on it.=A0The flag feels
> like a controller specific hack.

That's because it *IS* ...

Not clear what a good fix would look like.
But in general, SPI master controllers are
responsible for returning all bytes requested,
instead of (as with this one) a subset.

Suggesting the real issue is a buggy SPI
master controller and/or driver.  Can't it
issue multiple reads to collect all the data
requested?? =


- Dave
