From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 -next] spi: fix spi-sprd-adi build errors when
 SPI_SPRD_ADI=y and HWSPINLOCK=m
Date: Mon, 25 Sep 2017 12:31:03 -0700
Message-ID: <156431d9-a518-53e7-17d9-bb1ee0f637bb@infradead.org>
References: <ed5b8ca2-b853-755d-2801-57cc0b626508@infradead.org>
 <20170922092621.uq2xsvxangeetewi@sirena.org.uk>
 <9dc8b064-8a6c-98d2-4ade-088cbfd56fb1@infradead.org>
 <20170925161221.v23dpeljin5kakhz@sirena.org.uk>
 <449abd0e-8d8b-86e9-2b7a-65c27ab3171b@infradead.org>
 <CAMuHMdXwv7s-uBM2J1Rf5fw+2=N_VcPxCYHartgUxb56yrR23A@mail.gmail.com>
 <20170925192256.bmrm6gmb4idvomxb@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170925192256.bmrm6gmb4idvomxb@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 09/25/17 12:22, Mark Brown wrote:
> On Mon, Sep 25, 2017 at 09:20:31PM +0200, Geert Uytterhoeven wrote:
> 
>> The issue is builtin drivers that depend on a modular API.  The clean way
>> is to separate API and implementation, so the API can be builtin, and the
>> implementation can be modular.
>> Hence the API should provide stubs that call into function pointers, to be
>> registered by the module providing the implementation.
> 
> In this case the problem is even more basic in that the driver does
> actually depend on having hwspinlocks for any production use.
> 

so just add:
	depends on HWSPINLOCK

Is that satisfactory to you?

-- 
~Randy
