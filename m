Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742423D567E;
	Sun, 18 Oct 2026 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364928; cv=none; b=L/T6luL3DaoTjp92EfNz+/DErLrj+vWQTg3QwHYckXV1EeXWM+ejkpxb0BhpUdRQ/nh71QgpKHhLDBOlG4ehjuOsDfEqI0H7gmKd1+yTqmGPHdPZNMfl0PRfMr3Y4Z1irFcBaaN6ngcOYSsF/8M+t7cE9kRno5I1AJfAHkyLvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364928; c=relaxed/simple;
	bh=H6LmmGiOLW2RB2MTWkCvg7+eK4YKZ1NjaQZi8HlZB2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMQl2IgXvdSdWqhNo1Rd74y1bP6/3qf37vFpsOfWTN9Q0hbBLXMcl8j6LA78bWhEivpOddI1/+0sX9pagH3kL8hmBHSJHGfXJ7o/u5bRyXuWVaYXrl6HWfOAY6IEC/iwIc/Z9wQhsobvp7OYdi2RQxGma58sWdmM06pnrYi019s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=ZGhJDyMe; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="ZGhJDyMe"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 879F41073F8;
	Mon, 19 Oct 2026 01:08:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792364913;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=lObRH7lgJ2tY9c62lK2zWDxsiX6xmmPg5n9WVOkohgA=;
	b=ZGhJDyMeGEGxslZFOZ0Ze+iZ8KipMFowV6/wSQ+zgQVVT+7JKCK+0FQI23IcXefr3DmUWs
	6/yBmR5CfFoMSX+ag51TyDj/F8oqEeJx1kTc0vn1xhZuG6XD5tWeRKhAwddV41ghXzs824
	Q3d319wYaGIWrwmppbLasoSMSg1wq1bo571uNwGNchgZH3eFTygekRjNG79TE+7+bZk8bE
	yrVau/X7Y/sz1dVjNqmKFqO+82nam6xWsHZtN9kzV1UUhQU75PyU/6nOu9E426t4QCTwK2
	/3QQ3D687t5mv2QzvS3Jdnt7/QhnA2p+529E0r81Wh9KvUjaxgSxyO7aZ+kuaQ==
Message-ID: <fd15f846-94d4-44d8-a42d-5f13a7b18794@nabladev.com>
Date: Sun, 18 Oct 2026 23:38:09 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: spi: Add separate binding for
 dh,dhcom-board
To: Conor Dooley <conor@kernel.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Frank.Li@oss.nxp.com, imx@lists.linux.dev,
 Guenter Roeck <linux@roeck-us.net>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Frank Li <Frank.Li@nxp.com>, Ashish Yadav <ashish.yadav@infineon.com>,
 Colin Huang <u8813345@gmail.com>, Sanman Pradhan <psanman@juniper.net>,
 Thorsten Blum <blum@kernel.org>, Troy Mitchell <troy.mitchell@linux.dev>,
 Eddie James <eajames@linux.ibm.com>,
 Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:DH ELECTRONICS DHSOM SOM AND BOARD SUPPORT"
 <kernel@dh-electronics.com>, open list <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20261016205718.877668-1-Frank.Li@oss.nxp.com>
 <e7095176-44b8-4838-8443-2e515d34cb25@nabladev.com>
 <20261018-freeway-twitch-e813208aa9af@spud>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261018-freeway-twitch-e813208aa9af@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/18/26 9:37 PM, Conor Dooley wrote:
> On Sat, Oct 17, 2026 at 12:01:55AM +0200, Marek Vasut wrote:
>> On 10/16/26 10:57 PM, Frank.Li@oss.nxp.com wrote:
>>> From: Frank Li <Frank.Li@nxp.com>
>>>
>>> The dh,dhcom-board SPI device uses spi-cpha and spi-cpol properties,
>>> which are not permitted by the trivial-devices schema. Move it to a
>>> dedicated binding file that references spi-peripheral-props.yaml and
>>> explicitly allows those SPI mode properties.
>>>
>>> Fixes below CHECK_DTBS warnings:
>>>     arch/arm/boot/dts/nxp/imx/imx6ull-dhcor-maveo-box.dtb: spidev@0 (dh,dhcom-board): 'spi-cpha', 'spi-cpol' do not match any of the regexes: '^pinctrl-[0-9]+$'
>>>           from schema $id: http://devicetree.org/schemas/trivial-devices.yaml
>>
>> How come this did not trigger until now ?
>>
>>> Assisted-by: LLM
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>    .../bindings/spi/dh,dhcom-board.yaml          | 46 +++++++++++++++++++
>>>    .../devicetree/bindings/trivial-devices.yaml  |  2 -
>>>    2 files changed, 46 insertions(+), 2 deletions(-)
>>>    create mode 100644 Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml b/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
>>> new file mode 100644
>>> index 0000000000000..ed213cbe9b04c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
>>> @@ -0,0 +1,46 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/spi/dh,dhcom-board.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: DH electronics GmbH on-board CPLD trivial SPI device
>>
>> This does not look quite right, since compatible this is used only on:
>>
>> arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts
>>
>>         model = "DH electronics i.MX6ULL DHCOR on maveo box";
>>         compatible = "marantec,imx6ull-dhcor-maveo-box",
>> "dh,imx6ull-dhcor-som",
>>
>> So the whole
>>
>>         spidev@0 {
>>                 compatible = "dh,dhcom-board";
>>                 reg = <0>;
>>                 spi-cpha;
>>                 spi-cpol;
>>                 spi-max-frequency = <54000000>;
>>         };
>>
>> Should probably use a different compatible.
>>
>> Christoph, what device is this on this board ?
>>
>> (and this change should only be applied with RB from Christoph, I do not
>> have the hardware so I cannot tell what it really is)
>>
>>> +maintainers:
>>> +  - Marek Vasut <marex@denx.de>
>>
>> @nabladev.com
>>
>>> +  - Frank Li <Frank.Li@nxp.com>
>>> +
>>> +allOf:
>>> +  - $ref: spi-peripheral-props.yaml
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: dh,dhcom-board
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  spi-cpha: true
>>> +
>>> +  spi-cpol: true
>>
>> Wouldn't it make more sense to allow those properties for trivial SPI
>> devices in general ?
> 
> If the device requires them (which it probably does?), then standalone
> makes sense to actually set that requirement.

All right.

But in any case, the compatible string should likely be fixed here, this 
does not seem right. The dh,dhcom-board was describing some CPLD/FPGA on 
one of the evalboards.
