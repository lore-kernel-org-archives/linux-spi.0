From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3 0/7] spi: spi-mem: Add a direct mapping API
Date: Mon, 19 Nov 2018 22:13:22 +0100
Message-ID: <20181119221322.2b449570@bbrezillon>
References: <20181106160536.13415-1-boris.brezillon@bootlin.com>
 <20181115195640.GP2089@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@microchip.com>,
 Richard Weinberger <richard@nod.at>, Piotr Bugalski <bugalski.piotr@gmail.com>,
 linux-spi@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 Cyrille Pitchen <cyrille.pitchen@microchip.com>, linux-mtd@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181115195640.GP2089@sirena.org.uk>
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

Hi Mark,

On Thu, 15 Nov 2018 11:56:40 -0800
Mark Brown <broonie@kernel.org> wrote:

> On Tue, Nov 06, 2018 at 05:05:29PM +0100, Boris Brezillon wrote:
> > Hello,
> > 
> > Here is a v3 addressing the comment I received from Yogesh on the
> > m25p80 modifications. Note that this part is still untested (I only
> > tested on a spinand device so far), so that'd be great if someone
> > could test it.  
> 
> The SPI bits are all fine FWIW, leaving for a bit longer for testing but
> I could also just apply those bits immediately and send a branch as I
> think it's the MTD bits that really need the testing?

Feel free to apply the SPI bits.

Regards,

Boris

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
