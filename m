From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [RFC PATCH 2/2] mtd: m25p80: Use the SPI mem direct API to
 possibly improve performances
Date: Thu, 7 Jun 2018 17:18:46 +0200
Message-ID: <20180607171846.462e6639@bbrezillon>
References: <20180601143603.4047-1-boris.brezillon@bootlin.com>
 <20180601143603.4047-3-boris.brezillon@bootlin.com>
 <20180607170824.6c32bfc3@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vignesh R <vigneshr@ti.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@microchip.com>, linux-spi@vger.kernel.org,
 Marek Vasut <marek.vasut@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-mtd@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180607170824.6c32bfc3@xps13>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Thu, 7 Jun 2018 17:08:24 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Boris,
> 
> On Fri,  1 Jun 2018 16:36:03 +0200, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> 
> > Make use of the SPI mem direct mapping API.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > ---
> >  drivers/mtd/devices/m25p80.c | 149 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 89 insertions(+), 60 deletions(-)
> > 
> > diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> > index 1dd5f0420b5a..285fc94118ae 100644
> > --- a/drivers/mtd/devices/m25p80.c
> > +++ b/drivers/mtd/devices/m25p80.c
> > @@ -31,6 +31,10 @@
> >  struct m25p {
> >  	struct spi_mem		*spimem;
> >  	struct spi_nor		spi_nor;
> > +	struct {
> > +		struct spi_mem_dirmap_desc *write;
> > +		struct spi_mem_dirmap_desc *read;
> > +	} dirmap;
> >  };  
> 
> While reading this patch I was a bit confused with this naming. You
> refer these descriptors as 'flash->dirmap->read/write' which is
> confusing as this is not a function but a descriptor. Passing such
> variable to a function called spi_meme_dirmap_read/write() is also
> confusing IMHO (see below).
> 
> Would you mind renaming them with something like "read/write_desc"?

Sure. How about rdesc and wdesc to keep the names short?


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
