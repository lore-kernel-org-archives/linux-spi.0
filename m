From: Aurabindo Jayamohanan <mail@aurabindo.in>
Subject: Re: [PATCH] spi: sifive: check return value for platform_get_resource()
Date: Tue, 17 Sep 2019 17:13:32 +0000
Message-ID: <KINCBM4noQrzRVzR5KPbVAIlCxDi1_pLvCu6FYZT3Alj83dH1Q6Aspaph78A1c17AxxG1vSVuW-vdPSka8Cr-zdaGJbEZPQg4Q14gax4-H0=@aurabindo.in>
References: <20190917085627.4562-1-mail@aurabindo.in>
 <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com>
 <alpine.DEB.2.21.9999.1909170514130.11980@viisi.sifive.com>
 <ij_UksEXUomr_L7KQam02lHBryAppgwKDjG90VbVcRRUeXlKU8TAiBWc3aU8vt20Wvlwt_6NDgz5fuMSwwP1mm-1eP6GYWoR1Kbr0y0ElRk=@aurabindo.in>
 <alpine.DEB.2.21.9999.1909170709070.8198@viisi.sifive.com>
 <alpine.DEB.2.21.9999.1909170820470.21451@viisi.sifive.com>
Reply-To: Aurabindo Jayamohanan <mail@aurabindo.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.9999.1909170820470.21451@viisi.sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Paul,

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, September 17, 2019 8:51 PM, Paul Walmsley <paul.walmsley@sifive=
.com> wrote:

>
>
> I just recalled that YueHaibing already posted a patch to do this:
>
> https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1909041520130.13=
502@viisi.sifive.com/
>

Ah, sorry for the noise.
