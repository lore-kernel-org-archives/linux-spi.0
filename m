From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH RFC 00/18] mtd: spi-nor: Proposal for 8-8-8 mode support
Date: Mon, 22 Oct 2018 10:21:26 +0200
Message-ID: <20181022102126.529bebb3@bbrezillon>
References: <20181012084825.23697-1-boris.brezillon@bootlin.com>
 <20181019122527.GJ5895@sirena.org.uk>
 <20181019145920.43f9d5ec@bbrezillon>
 <20181021133600.GE8554@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mason Yang <masonccyang@mxic.com.tw>, Vignesh R <vigneshr@ti.com>,
 Julien Su <juliensu@mxic.com.tw>, Richard Weinberger <richard@nod.at>,
 linux-spi@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 linux-mtd@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, zhengxunli@mxic.com.tw
To: Mark Brown <broonie@kernel.org>, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181021133600.GE8554@sirena.org.uk>
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

On Sun, 21 Oct 2018 14:36:00 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Oct 19, 2018 at 02:59:20PM +0200, Boris Brezillon wrote:
> > Mark Brown <broonie@kernel.org> wrote:  
> 
> > > The SPI framework changes definitely look OK to me, if everyone agrees
> > > that this is a good way to go from a MTD point of view I'm happy to
> > > apply them.  I have no strong opinion on the MTD bits of the series.  
> 
> > Actually, Yogesh posted similar patches before me, so maybe you can
> > look at this series [1]. The spi/spi-mem side of things is rather
> > uncontroversial. Feel free to apply them if you think they're good
> > enough to go in.  
> 
> Ugh, unfortunately he didn't send me them so I'll have to try to find
> them on the list and it looks like there's been no review from any of
> the other MTD people.  It'd be good to get some consensus, yours seems a
> bit more complete so my inclination would be to go that way.

Indeed, looks like Yogesh version is not patching spi_setup() to
support octal mode. Anyway, it seems unfair to push for my own version
while I was clearly aware of Yogesh's patchset before posting my RFC
(the only reason I did not use his patches is laziness on my side: I had
my own working version, and the RFC was not really about these
spi/spi-mem aspects, more the spi-nor side of things :-)).

So, if you don't mind, I'll ask him to send a new version addressing
this problem (which should make our patches almost identical, except for
the naming: OCTAL vs OCTO), and I'll put my R-b.


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
