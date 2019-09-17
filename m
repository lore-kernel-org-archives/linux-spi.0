From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] spi: sifive: check return value for
 platform_get_resource()
Date: Tue, 17 Sep 2019 02:18:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.9999.1909170216200.4260@viisi.sifive.com>
References: <20190917085627.4562-1-mail@aurabindo.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: broonie@kernel.org, palmer@sifive.com, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
To: Aurabindo Jayamohanan <mail@aurabindo.in>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190917085627.4562-1-mail@aurabindo.in>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 17 Sep 2019, Aurabindo Jayamohanan wrote:

> platform_get_resource() may return NULL. If it is so, return -ENXIO
> 
> Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>


- Paul
