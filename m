From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/7] spi/pl022: move device disable to workqueue thread
Date: Tue, 22 Nov 2011 10:28:44 +0100
Message-ID: <CACRpkdYSGWAB29gHhKjpyEQDAaLoTbPM6-Qz0FosL3X4TNwxdg@mail.gmail.com>
References: <1321950301-4782-1-git-send-email-linus.walleij@stericsson.com>
	<4ECB5D2E.1000906@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Linus WALLEIJ <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Christopher BLAIR <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4ECB5D2E.1000906-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Nov 22, 2011 at 9:28 AM, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org> wrote:
> On 11/22/2011 1:55 PM, Linus WALLEIJ wrote:
>> =A0 =A0 =A0 if (list_empty(&pl022->queue) || !pl022->running) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pl022->busy) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(&pl022->adev->d=
ev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> We used to get warnings from checkpatch, for single line code inside {}.
> Don't we get them anymore?

It's driven by heuristics, I think it only warns on the first level since
elsewhere you may want braces for readability.

But I'll take it out when I add you Reviewed-by...

Linus

---------------------------------------------------------------------------=
---
All the data continuously generated in your IT infrastructure =

contains a definitive record of customers, application performance, =

security threats, fraudulent activity, and more. Splunk takes this =

data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
