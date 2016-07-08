From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/4] spi: s3c64xx: rename goto labels to meaningful names
Date: Fri, 08 Jul 2016 15:12:48 +0200
Message-ID: <577FA6D0.2070403@samsung.com>
References: <1467980304-14093-1-git-send-email-andi.shyti@samsung.com>
 <1467980304-14093-2-git-send-email-andi.shyti@samsung.com>
 <577FA677.7090708@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Kukjin Kim <kgene@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
To: Andi Shyti <andi.shyti@samsung.com>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <577FA677.7090708@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 07/08/2016 03:11 PM, Krzysztof Kozlowski wrote:
> On 07/08/2016 02:18 PM, Andi Shyti wrote:
>> In goto labels of the style of
> 
> s/In/The/
> 
>>
>>   err4:
>>   err3:
>>   err2:
>>   err1:
>>
>> is complex to insert in between new errors without renaming all
> 
> s/is/are/ (or just rewrite it... "The style of such goto labels... is")
> 
>> the goto statments. Replace the errX naming style to meaningful
> 
> s/statments/satements/

Yeah, nice job (to me)... error in error correction. Of course
"statements"...

BR,
Krzysztof
