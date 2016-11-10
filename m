From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Subject: Re: [PATCH v2] spi: rspi: rewrites the name of the function
Date: Thu, 10 Nov 2016 18:14:50 +0900
Message-ID: <58243A8A.6050309@jinso.co.jp>
References: <1478565346-4320-1-git-send-email-cm-hiep@jinso.co.jp> <20161109140538.2eeyrxrmjk2zaafd@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: geert+renesas@glider.be, linux-spi@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
        ryusuke.sakato.bx@renesas.com, linux-renesas-soc@vger.kernel.org,
        nv-dung@jinso.co.jp, h-inayoshi@jinso.co.jp
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161109140538.2eeyrxrmjk2zaafd@sirena.org.uk>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark.

Thanks for your reply.

On 11/09/2016 11:05 PM, Mark Brown wrote:
> On Tue, Nov 08, 2016 at 09:35:46AM +0900, Cao Minh Hiep wrote:
>> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>>
>> This patch rewrites the name of rspi_pio_transfer_in_or_out
>> function.
> This doesn't apply against current code, please check and resend.
It's ok, we don't need this patch any more because of the Arnd Bergmann's
"spi: rspi: avoid uninitialized variable access" patch.

Thanks,
Jinzai Solution Inc,
Hiep.
