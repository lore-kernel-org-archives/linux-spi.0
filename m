From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] spi: add spi_tegra driver
Date: Thu, 12 Aug 2010 16:24:24 +0100
Message-ID: <20100812152424.GB31982@n2100.arm.linux.org.uk>
References: <1280450224-25118-1-git-send-email-ccross@google.com>
	<AANLkTimUm_wj+gyxTa=X+845kLj1sZ9GF+jsmsBwxnLN@mail.gmail.com>
	<AANLkTinKNfPtaYYyUMmdTRewSKiRnTEfaf+pKkx_7jME@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-tegra@vger.kernel.org,
	Colin Cross <ccross@google.com>, linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net
To: Erik Gilling <konkers@android.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinKNfPtaYYyUMmdTRewSKiRnTEfaf+pKkx_7jME@mail.gmail.com>
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

On Wed, Aug 11, 2010 at 05:31:00PM -0700, Erik Gilling wrote:
> >> + =A0 =A0 =A0 if (!request_mem_region(r->start, (r->end - r->start) + =
1,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name(&pdev->dev))) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err0;
> >> + =A0 =A0 =A0 }
> >
> > I believe the platform bus does this for you already by calling
> > insert_resource() on all the platform bus ranges. =A0See if /proc/iomem
> > is any different with or without this call to verify.
> =

> You're right.  Didn't realize this

There is a big difference between what the platform bus does and what
drivers do.

The platform bus adds the resources to the resource tree as they stand
without marking them _busy_.  This means that they can be sub-divided
and other resources registered within their range.

request_mem_region() adds resources to the resource tree marking them
busy, detecting overlapping resources and indicating whether two
drivers are trying to claim the same resource region.  In other words,
it's a preventative measure against two device drivers accessing the
same region.

You're absolutely right to do what you're doing above, please continue
to do so.
