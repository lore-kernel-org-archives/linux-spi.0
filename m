From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] spi: pxa2xx: Set controller->max_transfer_size in dma mode
Date: Mon, 21 Oct 2019 14:08:57 +0300
Message-ID: <20191021110857.GR32742@smile.fi.intel.com>
References: <20191016195721.3714-1-daniel.vetter@ffwll.ch>
 <20191017064426.30814-1-daniel.vetter@ffwll.ch>
 <20191017070638.GB32742@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-arm-kernel@lists.infradead.org, Sam Ravnborg <sam@ravnborg.org>,
 Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi@vger.kernel.org,
 Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191017070638.GB32742@smile.fi.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Thu, Oct 17, 2019 at 10:06:38AM +0300, Andy Shevchenko wrote:
> On Thu, Oct 17, 2019 at 08:44:26AM +0200, Daniel Vetter wrote:
> > In DMA mode we have a maximum transfer size, past that the driver
> > falls back to PIO (see the check at the top of pxa2xx_spi_transfer_one).
> > Falling back to PIO for big transfers defeats the point of a dma engine,
> > hence set the max transfer size to inform spi clients that they need
> > to do something smarter.
> > =

> > This was uncovered by the drm_mipi_dbi spi panel code, which does
> > large spi transfers, but stopped splitting them after:
> > =

> > commit e143364b4c1774f68e923a5a0bb0fca28ac25888
> > Author: Noralf Tr=F8nnes <noralf@tronnes.org>
> > Date:   Fri Jul 19 17:59:10 2019 +0200
> > =

> >     drm/tinydrm: Remove tinydrm_spi_max_transfer_size()
> > =

> > After this commit the code relied on the spi core to split transfers
> > into max dma-able blocks, which also papered over the PIO fallback issu=
e.
> > =

> > Fix this by setting the overall max transfer size to the DMA limit,
> > but only when the controller runs in DMA mode.
> > =

> =

> Thank you, Daniel!

Mark, can be this applied?

-- =

With Best Regards,
Andy Shevchenko
