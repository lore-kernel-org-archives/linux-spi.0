From: Kirill Kapranov <kirill.kapranov@compulab.co.il>
Subject: Re: [PATCH -next] spi: Fix double IDR allocation with DT aliases
Date: Sat, 25 Aug 2018 20:54:53 +0300
Message-ID: <a1bba27e-a287-c162-a238-eeae1e84d63c@compulab.co.il>
References: <20180821095303.27664-1-geert+renesas@glider.be>
 <35fbd3ae-3ac3-f6ef-874b-3d99c4d4d29a@compulab.co.il>
 <20180823102121.GC5207@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180823102121.GC5207@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> For DT systems the dynamically allocated IDs start at the maximum
> positive ID and work down so in practice it is vanishingly unlikely that
> there will be a collision as idiomatic static DT IDs would be low
> integers.

Yes, this algorithm seems really bullet-proof. However, it isn't 
actually used now. The ID allocation algorithm using  atomic_dec_return 
call had been introduced 2006-01-08 as [1]. It was being used in the 
mainline kernel (with some improvements) up to 2017-08-16, when it has 
been replaced with the newer algorithm using Linux idr, accordingly [2].

Since idr_alloc call works incrementally, the situation of a 'fixed' ID 
squatting by a driver with 'dynamic ID' seems more than possible.
Therefore it would be justified to use a hardcoded constant 
SPI_DYN_FIRST_BUS_NUM (that was introduced in [2] and eliminated in 
[3]), but with a sufficiently greater value of the constant.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.18&id=8ae12a0d85987dc138f8c944cb78a92bf466cea0 

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.18&id=9b61e302210eba55768962f2f11e96bb508c2408
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.18&id=42bdd7061a6e24d7b21d3d21973615fecef544ef
