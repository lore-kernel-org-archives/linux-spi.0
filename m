From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] spi: sifive: check return value for
 platform_get_resource()
Date: Tue, 17 Sep 2019 08:21:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.9999.1909170820470.21451@viisi.sifive.com>
References: <20190917085627.4562-1-mail@aurabindo.in> <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com> <alpine.DEB.2.21.9999.1909170514130.11980@viisi.sifive.com> <ij_UksEXUomr_L7KQam02lHBryAppgwKDjG90VbVcRRUeXlKU8TAiBWc3aU8vt20Wvlwt_6NDgz5fuMSwwP1mm-1eP6GYWoR1Kbr0y0ElRk=@aurabindo.in>
 <alpine.DEB.2.21.9999.1909170709070.8198@viisi.sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Aurabindo Jayamohanan <mail@aurabindo.in>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.9999.1909170709070.8198@viisi.sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


I just recalled that YueHaibing already posted a patch to do this:

https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1909041520130.13502@viisi.sifive.com/


- Paul
