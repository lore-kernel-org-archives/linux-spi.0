From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 1/1] spi/atmel: add DT support
Date: Mon, 17 Dec 2012 11:13:51 +0100
Message-ID: <20121217101351.GI23971@game.jcrosoft.org>
References: <20121121151713.1F8873E0A47@localhost>
 <1353674679-13158-1-git-send-email-plagnioj@jcrosoft.com>
 <50AF7C19.8000306@atmel.com>
 <20121212151308.GK4398@game.jcrosoft.org>
 <20121215010317.C9C933E0BEC@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
 devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>,
 linux-arm-kernel@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20121215010317.C9C933E0BEC@localhost>
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

On 01:03 Sat 15 Dec     , Grant Likely wrote:
> On Wed, 12 Dec 2012 16:13:08 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> > On 14:37 Fri 23 Nov     , Nicolas Ferre wrote:
> > > On 11/23/2012 01:44 PM, Jean-Christophe PLAGNIOL-VILLARD :
> > > > the atmel_spi use only gpio for chip select
> > > > 
> > > > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > > 
> > > Seems simple and nice:
> > > 
> > > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > grant is ok to have this for 3.8?
> 
> Not sure how I missed this one. It's pretty straight forward and not
> risky, so no problem. However;
> 
> > > > the atmel_spi use only gpio for chip select
> 
> I know you know how to write a proper commit message. I'll need
> something better than the above before I commit it. I won't make you
> resubmit the patch, but do send me a better description.
> 
ok replace with this please

spi/atmel: add DT support

Use the newly introduce cs-gpios dt support on atmel.
We do not use the hardware cs as it's wired and have buges and limitations.
As the the controller's belief that only active-low devices/systems exists.

As done on non-dt system.

Best Regards,
J.
> g.
> 
