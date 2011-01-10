From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] spi: tegra: don't treat NULL clk as an error
Date: Mon, 10 Jan 2011 22:25:24 +0000
Message-ID: <20110110222524.GE12552@n2100.arm.linux.org.uk>
References: <1294657506-27510-1-git-send-email-jamie@jamieiles.com>
	<AANLkTikd7AZv+-aVf4=jwF+xjvq+1k_kAwLPz-+yP6=Q@mail.gmail.com>
	<20110110221802.GD12552@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Jamie Iles <jamie@jamieiles.com>, Erik Gilling <konkers@android.com>,
	linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110110221802.GD12552@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 10, 2011 at 10:18:02PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 10, 2011 at 01:58:12PM -0700, Grant Likely wrote:
> > On Mon, Jan 10, 2011 at 4:05 AM, Jamie Iles <jamie@jamieiles.com> wrote:
> > > Some platforms have been known to return NULL from clk_get() if they
> > > support only a single struct clk. =A0Whilst tegra doesn't do this, ma=
ke
> > > the drivers consistent with others.
> > >
> > > Cc: Erik Gilling <konkers@android.com>
> > > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> > =

> > Hi James,
> > =

> > If NULL does get returned, say due to a future change to the clock
> > code, then this change causes the driver to oops.  I'm not going to
> > apply this patch.
> =

> Please apply it - the clock API just defines struct clk as a cookie
> where errors are IS_ERR/PTR_ERR.  Other values must be considered by
> drivers as perfectly valid, including NULL.

Also note that drivers have no business ever dereferencing struct clks.
So if they oops, that's their own fault for dereferencing something
that they shouldn't.
