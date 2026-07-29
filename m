Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C952798EA;
	Wed, 29 Jul 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336408; cv=none; b=UDOv31Bv4AviF1Cqi5foxRU/eEV7AL46IUBQjFL6gED5D9Y1MEHPr+HEsizvinAFtBjb37VBl+yY7ohAZXSunmTMs6nh9bk1zkEdg9O0FO4Ikco0qEGmRebH7Z4nlJg3uXZFyHxZp4VyTRDmMpX5ssQ70oGPfPCC7xivbcJ24Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336408; c=relaxed/simple;
	bh=z3sN8IaRccpSQqRJ560poGjp4/SPSISWibKUzC/+zDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nee5Wv1Cf1zSvw/Vvt5+gPpP2L25wlCZmutS/9gDxph6agxf8UDK2OrPelQE6EVP8nAXtbLXK2a831h/zOhqynQVJCLNbvQBBaM/7w3sUIxwRpmOjs3G78nLMaEvl7A5XoFhXCwR1uPxtuNXMlT9rqeEHMnPTd+DJT3yG33TbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7EHzsVt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7EHzsVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCDE1F000E9;
	Wed, 29 Jul 2026 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336406;
	bh=nC71851yZY061LN93/yt7SyvzSyYKqzTFxrbHDUN/f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y7EHzsVtUKWZcVs68vYhx8I8iWijHFbUH9fj6YLPOC6CI+MoqGXGbcr62rhmkFA8k
	 Vydy3yAdxSzZk5NhIX1mAuwcg4ILqE0/DUhwhduHjl/58lJGfBzv3iMR1MWg5NZeFu
	 DzETempyoJZs3NILG4KP8gqoWtRFUHOu+Udkgv8kekSj0EGhDTt8OW0IvvKuRCFOVv
	 XaTdIEQfvMukSO7m7uZQ455peaSh2sp5Os0DMUj0iiXpSHAnBY/oDLi3DX55ICXk/y
	 o5hZDgPROz+DybMJWDN/rZaDtr2+W+dim4BNyJWEWZZqK6YS0GKzfWNJtVTCSF7Bs9
	 8gl+6avhUipXA==
Date: Wed, 29 Jul 2026 15:46:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <md.alam@oss.qualcomm.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Md Sadre Alam <mdalam@qti.qualcomm.com>
Subject: Re: [PATCH 2/3] spi: spi-qpic-snand: add quad mode support
Message-ID: <a9595e1c-fa08-4d1d-a13b-3ea89a27519a@sirena.org.uk>
References: <20260716-quad-v1-0-636f74da17e1@qti.qualcomm.com>
 <20260716-quad-v1-2-636f74da17e1@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="icRun6Aqpb/jzWOV"
Content-Disposition: inline
In-Reply-To: <20260716-quad-v1-2-636f74da17e1@qti.qualcomm.com>
X-Cookie: Captain's Log, star date 21:34.5...


--icRun6Aqpb/jzWOV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2026 at 10:57:46AM +0530, Md Sadre Alam wrote:
> Add support for quad (x4) transfer mode in the QPIC SPI NAND driver.
> The controller supports both single (x1) and quad (x4) SPI transfers,
> but the driver currently operates only in x1 mode.

> @@ -1025,12 +1040,16 @@ static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode,
>  		*cmd = SPINAND_WRITE_EN;
>  		break;
>  	case SPINAND_PROGRAM_EXECUTE:
> -		*cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
> -				SPI_WP | SPI_HOLD | OP_PROGRAM_PAGE);
> +		if (snandc->qspi->quad_mode)
> +			*cmd = (PAGE_ACC | LAST_PAGE | transfer_mode |
> +					SPI_WP | SPI_HOLD | OP_PROGRAM_PAGE);

This succeeds but does not initialize cmd, previously we'd accept and
use x1.

> @@ -1042,6 +1061,15 @@ static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode,
>  static int qcom_spi_read_page(struct qcom_nand_controller *snandc,
>  			      const struct spi_mem_op *op)
>  {
> +	int ret;
> +	u32 cmd;
> +	/* Call mapping once again to update the quad mode based on
> +	 * buswidth
> +	 */
> +	ret = qcom_spi_cmd_mapping(snandc, op, &cmd);
> +	if (ret < 0)
> +		return ret;
> +
>  	if (snandc->qspi->page_rw && snandc->qspi->raw_rw)
>  		return qcom_spi_read_page_raw(snandc, op);

We never reference cmd in the rest of the function, either we didn't
need to do the mapping or there's a missing update.

--icRun6Aqpb/jzWOV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpqElIACgkQJNaLcl1U
h9CmHQf9HBuWlN/o1161Wt82N1kmGc0KPYhi1HBn3t1mNF+rPZBQFFDqDvryHxg8
WavezWBqC9gK6lSoneByJmQbqh/x1iqjq5h6dEY9TbcvZb0mvU9cEegHQfjA7oX7
vCBKgIxULgxMLXkPg+QgGnDs4oU8+6dvex26we1c/w9uyS4JypHPKZ5sJXXmhkdJ
5TOukLcQwVHooTQr75iqKAe1ZhKCmiawo2gveF6r5hZzxyRlLUQi+bWACcx94k5f
Z1yeqcfn+ftUiHjA420AwA0Akpqq7NBodsMc2pZCEeFVvHqzm2ZrEu7KlQsZo4cc
VGLci+XXaWzd8YPXjmPe9C98KFsNXw==
=06hb
-----END PGP SIGNATURE-----

--icRun6Aqpb/jzWOV--
