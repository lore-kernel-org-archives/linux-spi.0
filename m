From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi/pl022: Activate resourses before deactivate them in
 suspend
Date: Sun, 28 Oct 2012 20:52:47 +0100
Message-ID: <CACRpkdbCfxnSSLR6GoSbAxtfnwOivxCCrLtwnR=9tpwpfACqTQ@mail.gmail.com>
References: <1349423012-18048-1-git-send-email-ulf.hansson@stericsson.com>
 <20121027214642.GH4564@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>,
 Russell King <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>,
 Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net,
 Ulf Hansson <ulf.hansson@stericsson.com>, linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121027214642.GH4564@opensource.wolfsonmicro.com>
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

On Sat, Oct 27, 2012 at 11:46 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Oct 05, 2012 at 09:43:32AM +0200, Ulf Hansson wrote:
>
>> To be able to deactivate resourses in suspend, the resourses must
>> first be surely active. This is done with a pm_runtime_get_sync.
>> Once the resourses are restored to active state again in resume,
>> the runtime pm usage count can be decreased with a pm_runtime_put.
>
> The PM core will ensure devices are runtime resumed before we enter
> suspend precisely due to this sort of issue.

I asked the very same question to Ulf (in speech, sorry
so you couldn't see it...)

So I guess we are talking about drivers/base/main.c

in device_prepare()
pm_runtime_get_noresume() is called
and in device_complete()
pm_runtime_put_sync() is called.

Both put into current for in
commit 88d26136a256576e444db312179e17af6dd0ea87
on sep 19th.

Yes it seems like it will do the job.

Ulf can you comment on this...

Yours,
Linus Walleij
