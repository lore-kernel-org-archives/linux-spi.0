From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/6] spi/pl022: skip default configuration before
	suspending
Date: Wed, 9 Nov 2011 13:31:44 +0100
Message-ID: <CACRpkdZLPnM-NqOOz3OjwCzKys9LvEt0Yxej4JMf4GCjfB_kyA@mail.gmail.com>
References: <1320835154-31303-1-git-send-email-linus.walleij@stericsson.com>
	<4EBA5C08.1040709@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Linus WALLEIJ <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Virupax SADASHIVPETIMATH <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4EBA5C08.1040709-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 9, 2011 at 11:55 AM, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org> wrote:
> On 11/9/2011 4:09 PM, Linus WALLEIJ wrote:
>>
>> - =A0 =A0 amba_vcore_enable(pl022->adev);
>> - =A0 =A0 amba_pclk_enable(pl022->adev);
>> - =A0 =A0 load_ssp_default_config(pl022);
>> - =A0 =A0 amba_pclk_disable(pl022->adev);
>> - =A0 =A0 amba_vcore_disable(pl022->adev);
>> - =A0 =A0 dev_dbg(dev, "suspended\n");
>> + =A0 =A0 dev_dbg(&adev->dev, "suspended\n");
>
> why adev->dev instead of dev?

Plain bug. It doesn't even compile with -DDEBUG :-/

I'll fix it up..

Linus

---------------------------------------------------------------------------=
---
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
