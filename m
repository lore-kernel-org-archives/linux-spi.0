From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] spi/omap2-mcspi: convert to the pump message infrastructure
Date: Tue, 15 May 2012 12:04:15 +0530
Message-ID: <CAM=Q2csCk3B=mQH+zifE8y0XfPW=qgjH=Ya9PunaWRHFo+dLfQ@mail.gmail.com>
References: <1336654665-693-1-git-send-email-shubhrajyoti@ti.com>
	<CACRpkdbb0pRmnN-E_M7MLZoN5c_vYNj4AWsSvv-9ZDJzh3Pbjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbb0pRmnN-E_M7MLZoN5c_vYNj4AWsSvv-9ZDJzh3Pbjw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

On Tue, May 15, 2012 at 1:42 AM, Linus Walleij <linus.walleij@linaro.or=
g> wrote:
> On Thu, May 10, 2012 at 2:57 PM, Shubhrajyoti D <shubhrajyoti@ti.com>=
 wrote:
>
>> This patch converts the OMAP SPI driver to use the SPI infrastructur=
e
>> pump message queue.Also fixes the below warning.
>> master is unqueued, this is deprecated
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>
> Final version of the patch?
Lest someone has comments.

> Acked-by: Linus Walleij <linus.walleij@linaro.org>
Thanks.

>
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
