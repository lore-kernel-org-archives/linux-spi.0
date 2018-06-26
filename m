From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI controller
Date: Tue, 26 Jun 2018 18:42:37 +0300
Message-ID: <CAHp75Vda=zqOoAk955B9jLRKE0u34jrV8mMC6RG+RtvrENTbVw@mail.gmail.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
 <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <CAHp75Vesytovn1s-L0RQbEi6Tua=8qKc8a8yDkFmadgscW_UAw@mail.gmail.com>
 <4046ba78-b6c0-c09b-43e2-e3c2e550be9f@exceet.de> <CAHp75VfskABz+KrnLzDTYH=1cESimi++3HwQ2a1tiWkPTqf=HQ@mail.gmail.com>
 <20180626154728.16e94b58@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Frieder Schrempf <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626154728.16e94b58@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jun 26, 2018 at 4:47 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Hi Andy,
>
> On Tue, 26 Jun 2018 16:18:44 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>>
>> > What is wrong? Some newlines are missing here between the MODULE_ macr=
os,
>> > but in my original patch it seems correct.
>>
>> It should be like
>>
>> MODULE_FOO(...);
>> MODULE_BAR(...);
>> MODULE_BAZ(...);
>>
>> One macro =E2=80=94 one line.
>
> It's not Frieder's fault, it's Yogesh mailer which messed-up the
> formatting. Just look at the original patch and you'll see.

One problem less, then.
Good!


--=20
With Best Regards,
Andy Shevchenko
