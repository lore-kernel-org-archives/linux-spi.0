From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2 3/3] spi: spi-pl022: Minor simplification for runtime pm
Date: Sun, 07 Oct 2012 23:35:45 +0200
Message-ID: <2601524.77SEIkPWcO@vostro.rjw.lan>
References: <1349337881-15917-1-git-send-email-ulf.hansson@stericsson.com>
 <CAPDyKFqZXKtpJ8vSFKfZuD8FGayQUhmYKtZKzkZ15jKRA5nu6Q@mail.gmail.com>
 <CACRpkdb9mLy1640Y9xuN_EgUd2xCwjpc1ErZaBmLOcJT4ffaxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Vipul Kumar Samar <vipulkumar.samar@st.com>,
 Russell King <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <damm@opensource.se>,
 spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdb9mLy1640Y9xuN_EgUd2xCwjpc1ErZaBmLOcJT4ffaxw@mail.gmail.com>
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

On Friday 05 of October 2012 14:19:57 Linus Walleij wrote:
> On Thu, Oct 4, 2012 at 11:07 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
> > Mark, I am not sure this particular patch is actually wanted. Realized
> > that when reading up on the driver/base/* patches for PM changes this
> > summer. Especially how device probe/suspend/shutdown etc. has been
> > changed for runtime PM point of view.
> 
> Mark will get you for top-posting ;-)
> 
> >> From: Ulf Hansson <ulf.hansson@linaro.org>
> >>
> >> In probe pm_runtime_put_autosuspend has the same effect as doing
> >> pm_runtime_put. This due to upper layer in driver core is preventing
> >> the device from being runtime suspended by a pm_runtime_get*.
> >>
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >> ---
> >>  drivers/spi/spi-pl022.c |    5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> >> index a1db91a..51b7a95 100644
> >> --- a/drivers/spi/spi-pl022.c
> >> +++ b/drivers/spi/spi-pl022.c
> >> @@ -2246,10 +2246,9 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
> >>                 pm_runtime_set_autosuspend_delay(dev,
> >>                         platform_info->autosuspend_delay);
> >>                 pm_runtime_use_autosuspend(dev);
> >> -               pm_runtime_put_autosuspend(dev);
> >> -       } else {
> >> -               pm_runtime_put(dev);
> >>         }
> >> +       pm_runtime_put(dev);
> >> +
> >>         return 0;
> 
> I'm paging Rafael and Magnus for their comments so we don't
> overload Mark with runtime PM semantics...

The change looks OK.  The functional difference is that the .idle() callback
will be run earlier in the "use autosuspend" case, but that shouldn't be a big
deal.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
