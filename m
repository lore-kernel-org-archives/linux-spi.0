From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH v2 3/6] mtd: m25p80: add support to
	parse the SPI flash's partitions
Date: Tue, 10 Aug 2010 00:14:54 -0700 (PDT)
Message-ID: <796604.30863.qm@web180307.mail.gq1.yahoo.com>
References: <AANLkTik9cy+at2n28U+Mut4RD6_cJ9uRZzjf+H86d-rp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	spi-devel-general@lists.sourceforge.net
To: Mingkai Hu <Mingkai.hu@freescale.com>,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <AANLkTik9cy+at2n28U+Mut4RD6_cJ9uRZzjf+H86d-rp@mail.gmail.com>
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



--- On Mon, 8/9/10, Grant Likely <grant.likely@secretlab.ca> wrote:


> > + =A0 =A0 =A0 nr_parts =3D
> of_mtd_parse_partitions(&spi->dev, np, &parts);

Let's keep OF-specific logic out of drivers like
this one ...  intended to work without OF.

NAK on adding dependencies like OF to drivers
and other infrastructure that starts generic.
