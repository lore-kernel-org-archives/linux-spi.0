From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 3/3] spi: spi-pl022: Minor simplification for runtime pm
Date: Fri, 5 Oct 2012 14:19:57 +0200
Message-ID: <CACRpkdb9mLy1640Y9xuN_EgUd2xCwjpc1ErZaBmLOcJT4ffaxw@mail.gmail.com>
References: <1349337881-15917-1-git-send-email-ulf.hansson@stericsson.com>
	<1349337881-15917-4-git-send-email-ulf.hansson@stericsson.com>
	<CAPDyKFqZXKtpJ8vSFKfZuD8FGayQUhmYKtZKzkZ15jKRA5nu6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>,
	Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAPDyKFqZXKtpJ8vSFKfZuD8FGayQUhmYKtZKzkZ15jKRA5nu6Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Oct 4, 2012 at 11:07 AM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> Mark, I am not sure this particular patch is actually wanted. Realized
> that when reading up on the driver/base/* patches for PM changes this
> summer. Especially how device probe/suspend/shutdown etc. has been
> changed for runtime PM point of view.

Mark will get you for top-posting ;-)

>> From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> In probe pm_runtime_put_autosuspend has the same effect as doing
>> pm_runtime_put. This due to upper layer in driver core is preventing
>> the device from being runtime suspended by a pm_runtime_get*.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>  drivers/spi/spi-pl022.c |    5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
>> index a1db91a..51b7a95 100644
>> --- a/drivers/spi/spi-pl022.c
>> +++ b/drivers/spi/spi-pl022.c
>> @@ -2246,10 +2246,9 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
>>                 pm_runtime_set_autosuspend_delay(dev,
>>                         platform_info->autosuspend_delay);
>>                 pm_runtime_use_autosuspend(dev);
>> -               pm_runtime_put_autosuspend(dev);
>> -       } else {
>> -               pm_runtime_put(dev);
>>         }
>> +       pm_runtime_put(dev);
>> +
>>         return 0;

I'm paging Rafael and Magnus for their comments so we don't
overload Mark with runtime PM semantics...

Yours,
Linus Walleij

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
