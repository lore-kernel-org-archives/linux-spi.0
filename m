From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v3 5/7] mtd: devices: m25p80: Use the spi-mem dirmap API
Date: Mon, 14 Jan 2019 09:59:18 +0100
Message-ID: <20190114095910.7280c8bb@bbrezillon>
References: <20181106160536.13415-1-boris.brezillon@bootlin.com>
 <20181106160536.13415-6-boris.brezillon@bootlin.com>
 <VI1PR04MB5726AF470280F23B40BC704199800@VI1PR04MB5726.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vignesh R <vigneshr@ti.com>, Marek Vasut <marek.vasut@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Tudor Ambarus <tudor.ambarus@microchip.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, Mark Brown <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Piotr Bugalski <bugalski.piotr@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Cyrille Pitchen <cyrille.pitchen@microchip.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <VI1PR04MB5726AF470280F23B40BC704199800@VI1PR04MB5726.eurprd04.prod.outlook.com>
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

On Mon, 14 Jan 2019 08:49:35 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Boris,
> 
> I have tested this patch on NXP FlexSPI controller having SPI-NOR flash MT35x.
> Added tested-by tag.

Would be easier for me if you had added it in a formal way so that
patchwork can collect it:

Tested-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
