Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE783B530A;
	Thu,  1 Oct 2026 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842922; cv=none; b=T6S0iuR8WG3NAGn+89MfK01aJezhdhdSP2GZ1ogm2czbzl4f2ymNTjaWY5ffCidoxKOE7rou+sCGKVAyPZpT/69Bn+HTTjK9ndZvHzh5iwk3anxyfRxxw8OBtUUgrSUry196CyqGMS663wwDvv0cm7tcJ57VILycDNTynYFOGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842922; c=relaxed/simple;
	bh=HLsddBUUW/0tuwomUmic6NJjZYQ6efWAmN8ApSUpmKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type; b=DTUWWXUBFoWiNLskmPU74RYsFpx8GLwQDYM4l3dr+Fn2HdyE+BbCtOPde8h6omvHLR2Tehmx2AIy5VsmS1dcK/1TLA2Zaz6ocfsU0wPTaQJ8lDnhHMIrJZuwnBOoGMvH/9PyG3Enydd0QX49K7UkNSlhG+F1EoH4z8uahY9FUlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWdDqQ+b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWdDqQ+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5C61F000FF;
	Thu,  1 Oct 2026 08:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790842913;
	bh=CfSAkyKmAFbbaUlyoh5pgwABRhARhGzkTkaK5zTkCQI=;
	h=Date:Subject:To:Cc:From;
	b=eWdDqQ+bLedjvVWrP+0kajcSKWyxVTqsCTDTmQQeCEnLEvQdBz+XpMoXmZ0HFjZj/
	 d52rI6zk9w44vzqO6bTg2ULkF3Vejm0vZkWU33ewcCJRcDmR/zagjMvhsvLFkqZcyx
	 MF8EB4nixZW0+zAugCSmLf/ynTPSm3/qaqLbNkqEZ8gF2rLyOgVAbAMdcsOY0PAzpd
	 pBK0nio20R04e7h4RvsdH9uTRfsMpIoLpddFJn2llo/9jGxJjOzuttT2QQN4QZDt6W
	 kMhqhDIkBvLtsZQT5zT203kThMIH7NV5WR/UKgbI9RAOvjVMnJwaw7N51zzjg3ai87
	 z8HysgMV3BSCQ==
Message-ID: <fb0f7ef9-23ea-44f8-a30d-509ecee841ad@kernel.org>
Date: Thu, 1 Oct 2026 10:21:45 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: add SPI IPM v59 compatible for
 mt7987 and mt7989
To: =?UTF-8?B?VGltIEt1byAo6YOt5bu356yZKQ==?= <Tim.Kuo@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?UTF-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
 =?UTF-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
 <SkyLake.Huang@mediatek.com>, =?UTF-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?=
 <Sam.Shih@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/10/2026 10:15, Tim Kuo (郭廷笙) wrote:
> On Wed, 2026-09-30 at 12:36 +0200, Krzysztof Kozlowski wrote:
>> On Tue, Sep 29, 2026 at 02:25:15PM +0800, Tim Kuo wrote:
>>> MTK mt7987 and mt7989 SPI hardware has been updated to IPM v59 SPI
>>> IP and
>>> it differs from earlier IPM designs, most visibly in the tick delay
>>> field
>>> of SPI_CMD_REG, so it needs its own fallback compatible rather than
>>> reusing
>>> "mediatek,spi-ipm".
>>>
>>> Signed-off-by: Tim Kuo <Tim.Kuo@mediatek.com>
>>> ---
>>> v2: Add mt7987 and mt7989 real device compatible
>>>
>>>  .../devicetree/bindings/spi/mediatek,spi-mt65xx.yaml         | 5
>>> +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-
>>> mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-
>>> mt65xx.yaml
>>> index 3bf3eb1f8728..d2c740572d85 100644
>>> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-
>>> mt65xx.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-
>>> mt65xx.yaml
>>> @@ -39,6 +39,11 @@ properties:
>>>                - mediatek,mt7988-spi-single
>>>                - mediatek,mt8188-spi-ipm
>>>            - const: mediatek,spi-ipm
>>> +      - items:
>>> +          - enum:
>>> +              - mediatek,mt7987-spi
>>> +              - mediatek,mt7989-spi
>>> +          - const: mediatek,spi-ipm-v59
>>
>> No, look at the binding and recent commits. This should be a specific
>> compatible. Git history easily tells you that.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Thanks for the review. I went back through the binding and the history;
> let me confirm I took the right lesson from it before I send v3, and
> ask one thing about the DTS.

Did you just paste here LLM output to your prompt and followed up by
typical agent question "is this what you wanted"? If so, straight way to
get yourself PLONKed, because it is a plague.

Best regards,
Krzysztof
