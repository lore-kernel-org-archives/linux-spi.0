Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BC4366076
	for <linux-spi@vger.kernel.org>; Mon,  9 Feb 2026 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770650904; cv=none; b=k9rSKToiswoQtSIned4NW9bwumlrnDiQcOjbEiHfqeex9JcilDT7LIQsaSwQ8uumqPLMtcBikjIV1+TIQED98DMRQLU31/AmjzbRiRXK/6RtPEEobtzUnOAdPlbDdCd12BfSYjy0TlZR1WoGS0zGbi73ydReCgccFkl92ANyQok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770650904; c=relaxed/simple;
	bh=DTkjd0tNFRfFZrVjzA71TMao0DYCnAq9XUrVmaOJWbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bGPjjOaffbQNo04hQg3FYsxOB/OZXVuYhAMDflo8Zk5okbncMZNt4DBzt8/UWsAqMNaiVHyUsU1RBPnM2VI7ekjrmqajBHfvCAvBMFyHHlNbQBc/829eezeJuFQk2PHyWonzUQnbYqRdW9vgS7NWsDsoSaFvpFpTF66FB7wOvY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n7IhtTW3; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n7IhtTW3"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45c9fdf2a06so3050877b6e.2
        for <linux-spi@vger.kernel.org>; Mon, 09 Feb 2026 07:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770650902; x=1771255702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9KZTHcq5eFjr9M/3mrNSgDFRjuluDN92D/wtKMFTk4A=;
        b=n7IhtTW3STJNle7++iMfAeuQvnynGeL+/R7BZBFHavWmez6as9nYPTkQqxk3ACnkPo
         ccUBvAKe57b4axD876mXMorFGSBF84VrwIZhaUenYvOsQZxNekL/P853sJs+FaLJkVmU
         q+YFVxK+Iyz/wIjp23w+6rPENtHk0765gImweDHLggXBeY63009AJEgiICdvRntqGohq
         bdShYlnO2xVLvVSb0HEcMDf5Q58xJwBnFWWVJVhyeS03miv6nCUVprwAAfUgzebyr9ja
         7J/HCpKDNP6bSfrBddNhfzze3x/eXyNpaSPx2gQ+0fydPCZyryR9fylNliNN1EZGZxnQ
         GAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770650902; x=1771255702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KZTHcq5eFjr9M/3mrNSgDFRjuluDN92D/wtKMFTk4A=;
        b=HQkh+1WrMW13unhOQq5Ih7OkbPxNrpXh+ZEcE9Rp2JNUwOHCkvaNnTRbKRn9Gt/NDw
         ZASXVTr3AGKsg1ca5eeCHR1Nr8T7yKJV54BdFZPY/prIwU4acWW9L669/C+MrMhgwXvs
         plIPsdMuAuN3nKpKnDtvBkGfgA7S0sbQid8xm4klvWg1xeOqeAH8HJBymWBoWTSzfVat
         usTAgIWNfG+O0uxNp+Nii6f25JZkpDTfwKFDTuvG/JZb23SLsBGO2Qzjng5Kd1Bk4O8R
         3gTHsLJhmMC8loC+6016721vSfj/3YHGZ5ceMp306sQH3ksEAR4dGbGtU7BCIng9h/Ka
         DduQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsoOJiTbef4HadlIiQh76v1+QMLGi6nvhxGbSc60srGc1FehcC+GCtj37Pm8vMFsLOyGomhv3bZvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYTcAkXCgB+Q9/E6CZryrtyv4HMezje0MmBA6B/cdeRjG9snCw
	6mjInAwuyHqt1roLTR/oTTxxYQpwdYGUVxaC0zJwQ4wXW/GyAZyLlu+kAHTy8eJ1r04=
X-Gm-Gg: AZuq6aJT/VpD3nJd9xZ04rA6EIV/byzMxetfcA+ZE7/98gDR/e8NiQSkmtQu9rau79t
	MQLJvR0HlQwhCj1VJTudnNZy2AsKQGJoEAfFTE2sVScuTinr87aK52BcFYguweff1K3iauzQfD/
	9GcCKoUzp8pO12uzPpTMaEClupCIk9L4aw9/3QDv7y1vobPoAkRU750qoU0Q0m/lWWZDVA98Vr9
	YCo3KrwHepe4+OBCJFIf402/n/AKkcz1HqCYI8Lnt+Od8gW3zFWPYUKvsjstcbax1O0CmoIUsnx
	ZE+2p4DWnwBkRDg9IVOKQH6Ef9tIxXfq0MPOkQhveL9nv36DHsT0bF8346XE33guf8pqbeOa7qD
	zFKi8JcmkNL4oFTeGNp10dlMJPiS93QUKkEdcPD1o3hPSN+QOV2Q09hM+AuRHNPwZ1X+++zsSG2
	Zwrzhq+smdhem3XGQykYvI2LDNAnDBTEBvN31uWM8bHquCB+UE/3doRf+ZFycm
X-Received: by 2002:a05:6808:c198:b0:45e:aba8:124e with SMTP id 5614622812f47-462fcf53c0bmr5694687b6e.23.1770650902598;
        Mon, 09 Feb 2026 07:28:22 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cee0:eb0c:b683:ad1d? ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462feb0d786sm6700789b6e.11.2026.02.09.07.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 07:28:22 -0800 (PST)
Message-ID: <becd9db1-818f-4aa8-8362-91a711861839@baylibre.com>
Date: Mon, 9 Feb 2026 09:28:21 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] iio: backend: add devm_iio_backend_get_by_index()
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
 <550323d752213f177b7673bdd42e667f1d2228cb.1770393792.git.antoniu.miclaus@analog.com>
 <c731b6fba72286707821ea6e7722835ba45f089c.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <c731b6fba72286707821ea6e7722835ba45f089c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/8/26 3:24 AM, Nuno Sá wrote:
> On Fri, 2026-02-06 at 18:07 +0200, Antoniu Miclaus wrote:
>> Add a new function to get an IIO backend by its index in the
>> io-backends device tree property. This is useful for multi-channel
>> devices that have multiple backends, where looking up by index is
>> more straightforward than using named backends.
>>
>> The new function directly uses the index to find the backend reference
>> in the io-backends property, avoiding the need for io-backend-names.
>>
>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>> ---
>>  drivers/iio/industrialio-backend.c | 51 ++++++++++++++++++++++++++++++
>>  include/linux/iio/backend.h        |  2 ++
>>  2 files changed, 53 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-
>> backend.c
>> index 447b694d6d5f..3b692d48481e 100644
>> --- a/drivers/iio/industrialio-backend.c
>> +++ b/drivers/iio/industrialio-backend.c
>> @@ -1008,6 +1008,57 @@ struct iio_backend *devm_iio_backend_get(struct device *dev,
>> const char *name)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, "IIO_BACKEND");
>>  
>> +static struct iio_backend *
>> +__devm_iio_backend_fwnode_get_by_index(struct device *dev,
>> +				       struct fwnode_handle *fwnode,
>> +				       unsigned int index)
>> +{
>> +	struct fwnode_handle *fwnode_back;
>> +	struct iio_backend *back;
>> +	int ret;
>> +
>> +	fwnode_back = fwnode_find_reference(fwnode, "io-backends", index);
>> +	if (IS_ERR(fwnode_back))
>> +		return dev_err_cast_probe(dev, fwnode_back,
>> +					  "Cannot get Firmware reference\n");
>> +
>> +	guard(mutex)(&iio_back_lock);
>> +	list_for_each_entry(back, &iio_back_list, entry) {
>> +		if (!device_match_fwnode(back->dev, fwnode_back))
>> +			continue;
>> +
>> +		fwnode_handle_put(fwnode_back);
>> +		ret = __devm_iio_backend_get(dev, back);
>> +		if (ret)
>> +			return ERR_PTR(ret);
>> +
>> +		back->idx = index;
>> +
>> +		return back;
>> +	}
>> +
>> +	fwnode_handle_put(fwnode_back);
>> +	return ERR_PTR(-EPROBE_DEFER);
>> +}
> 
> I believe we don't necessarily need this. Why can't we use io-backend-names? I get
> that in here we just want something matching the number of channels we have so giving
> names is probably does not add much added value. But still, I would prefer t have
> more simplicity in the API and it should be fairly easy for the frontend to use the
> names argument.
> 
> _ Nuno Sá
> 

IMHO, using names in this case would just be annoying because we would have to
sprintf the string to add the index to the string. And also have to spend time
coming up with more complex DT bindings. Using the index seems much simpler.

If you really feel strongly about it though, maybe we could make a
devm_iio_backend_fwnode_get_fmt() function instead that handles the
sprintf() part so that we only have to write that once?


