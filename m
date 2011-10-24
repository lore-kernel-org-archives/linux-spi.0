From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi/pl022: Enable clock in probe an use runtime_idle
Date: Mon, 24 Oct 2011 16:58:07 +0200
Message-ID: <CAKnu2Mov-ORJ=KD0g0Wd-gr5pHmCMccWmZ74+8mhDzPJzUqr7g@mail.gmail.com>
References: <1319206124-17549-1-git-send-email-ulf.hansson@stericsson.com>
	<20111024120342.GQ8708@ponder.secretlab.ca>
	<20111024125030.GB17693@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net, Lee Jones <lee.jones@linaro.org>,
	Ulf Hansson <ulf.hansson@stericsson.com>,
	linux-arm-kernel@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111024125030.GB17693@n2100.arm.linux.org.uk>
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

2011/10/24 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Oct 24, 2011 at 02:03:42PM +0200, Grant Likely wrote:
>> On Fri, Oct 21, 2011 at 04:08:44PM +0200, Ulf Hansson wrote:
>> > Since we are always runtime resumed when leaving probe
>> > the clock must be enabled. To accomplish that we are able
>> > to be runtime suspended after probe in the case when no
>> > request is going to be recieved, a runtime_idle function
>> > has been implemented.
>> >
>> > Change-Id: I6cb86f2cad30ecaab16f512daf4674b039b18213
>> > Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>> > Reviewed-on: http://gerrit.lud.stericsson.com/gerrit/34447
>>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>>
>> Since it depends on Russell's tree, I'm okay with it going in that way.
>
> I've received this patch in the patch system, but I'm not planning to
> apply it yet because it depends on two branches in my tree (amba and clk).

We can fixup that in the aftermath of the merge window, no
hurries.

Yours,
Linus Walleij
