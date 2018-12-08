From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [v2,1/3] mtd: spi-nor: Add support for is25lp016d
Date: Sat,  8 Dec 2018 13:30:31 +0100
Message-ID: <20181208123031.9847-1-boris.brezillon@bootlin.com>
References: <1541696684-21235-2-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>,
 Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-mtd@lists.infradead.org,
 Biju Das <biju.das@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Marek Vasut <marek.vasut@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Simon Horman <horms@verge.net.au>, Richard Weinberger <richard@nod.at>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1541696684-21235-2-git-send-email-fabrizio.castro@bp.renesas.com>
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

On Thu, 2018-11-08 at 17:04:41 UTC, Fabrizio Castro wrote:
> The is25lp016d is found on the iwg23s from iWave, therefore
> add driver support for it so that we can upstream board support.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
