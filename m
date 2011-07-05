From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 0/5] remove spi-s3c24xx-gpio driver
Date: Tue, 05 Jul 2011 14:45:25 +0900
Message-ID: <009e01cc3ad6$c14049d0$43c0dd70$%kim@samsung.com>
References: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
	<20110628212443.GI21138@trinity.fluff.org>
	<87ipro4loa.fsf@macbook.be.48ers.dk>
	<BANLkTi=693aHH=8BTAyrKWc1padiozpT6A@mail.gmail.com>
	<87ei2c4jch.fsf@macbook.be.48ers.dk>
	<20110704165134.GF28042@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	'Ben Dooks' <ben@trinity.fluff.org>, ben-linux@fluff.org,
	linux-arm-kernel@lists.infradead.org
To: 'Grant Likely' <grant.likely@secretlab.ca>,
	'Peter Korsgaard' <jacmet@sunsite.dk>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20110704165134.GF28042@ponder.secretlab.ca>
Content-language: ko
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

Grant Likely wrote:
> 
> On Wed, Jun 29, 2011 at 07:51:10PM +0200, Peter Korsgaard wrote:
> > >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
> >
> >  >> Great, will you handle the series or should it go through the spi
tree?
> >
> >  Grant> With the big spi driver rename, it should probably either go via
the
> >  Grant> spi tree, or be put into a topic branch that can be merged by
both the
> >  Grant> spi and samsung trees.
> >
> > Both is fine by me. Let me know if you want me to do something.
> 
> It's pretty minimal arch/arm impact, and it depends on the big rename
> patch, so why don't I just merge it directly into spi/next without a
> topic branch.

Hi Grant,

I agree with you, it is not expected this makes some conflicts between spi
and samsung tree.

I think Ben's ack is enough on this, if required,
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
