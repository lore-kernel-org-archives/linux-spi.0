Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671572;
	b=AK7n5G1GdZY2vT1q7FLhKgbII1nxyFuIa3u90svfAe/ZkntmypJVlRkt3Iz9S0f19dv2
	 wX4S5rzEg/pMizSUqQyv+YCQ/m79mokbzsvX9/Sf3+y7Z3Nn8CjsmLkKHpTWJXGEzPRvr
	 FM6ihpaFJ1/c+DODvKzhnrL1DQ+oCkRAXTfUc/AJO+tMlfJGHPs70KGe7tQq82CbN+FjW
	 Ff9MPNmtim+E3Nbjm81JYdDltf2GPSCWdVWgN+oEanYSvq0vm0Bva8VRH7ZTvECvIyDl/
	 JTV66bjQn/g8UjCFk3ox9vCs4pEQbcTHDay3X4mIkPa9KcwsSRRUgMaKX4oPgq7jh2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671572;
	h=Received:DKIM-Signature:Mime-Version:Content-Type:Date:Message-Id:
	 Subject:Cc:From:To:X-Mailer:References:In-Reply-To;
	bh=OklgHJFN1eZ/51mpY2UmRhLUFr3RqxZaXQXuRRPUEdE=;
	b=c1fj6Hjzw7VR5/xVDyCYoQwq0187ySBu2aY7eHxY7n2QWuslUCNNnyr81xzuFyIN3aiQ
	 hxU54KbpT5/CFe6ReWD9wy292d4mQiF3QSL98nreLvPe551I9QjSBaFOhOOTcm1SH9nMH
	 xCQ7qIbk7HfbAsrpQ6Fx+P4yXmJHf56Ly9HRpik6oAOuiqAN8JdEjVLTd6awqy6Y6Nmx6
	 hR3TAtPlCVrJtWl6Lxau2NajlrXBaUyvlHkv0Sju3WI2RzAf1K1OcKCoyxjtY4yu86g++
	 urpKwgYk4gzPVlQjUIPMJx3HgwayyAM4vgErfRxdjUYuot5d2GqIjaHni1ttf7UUhXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldMZPbdg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3A72A606A319;
	Thu, 22 Oct 2026 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldMZPbdg
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 48AFD1F000C1;
	Thu, 22 Oct 2026 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792671571;
	bh=OklgHJFN1eZ/51mpY2UmRhLUFr3RqxZaXQXuRRPUEdE=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=ldMZPbdgvKK5TQGrow84FHcVSYxlGmDyeiIQuBFLg5bI1wAPBMyMt5GrmwLVAd/92
	 OoR2kIydDv87gReRoqk7W4bThCR70RlAFnssNmYrtP4fWRFwkTI6ZyQBcsEv9fMxbu
	 W+fHQdzMznqJjW+h7JPJmD/+LLqLR/9ClTJG2tgHkakd7qfO01GvKfKa1q1pC0hU7F
	 efAGnEEdBGYmpjQaTTmmPbk/JObpx0HWlGFsYWoZVw3WS3baSVcNnfi+E9B2fg5Wod
	 uqTrMJrCUcTqpk635IxObpTjqzCSDUbshuPlo1sw9F2fy+KKlU4zb4zJi6nf9hU0dA
	 ddFNluFgcPDug==
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=1af248fcc003f2e9190f10866a1810a2857490b1df2b79d3d9fd96a2faf7;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 22 Oct 2026 14:19:27 +0200
Message-Id: <DMBD190498R4.3PX7VO4SXKU3C@kernel.org>
Subject: Re: [PATCH v1 2/4] mtd: spi-nor: Support mixed 1S-xD-xD DTR
 protocols in spi_nor_spimem_setup_op()
Cc: "Pratyush Yadav" <pratyush@kernel.org>, "Takahiro Kuwano"
 <takahiro.kuwano@infineon.com>, "Mark Brown" <broonie@kernel.org>, "Richard
 Weinberger" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Changhuang Liang"
 <changhuang.liang@starfivetech.com>
X-Mailer: aerc 0.20.0
References: <20261022102614.75696-1-changhuang.liang@starfivetech.com>
 <20261022102614.75696-3-changhuang.liang@starfivetech.com>
 <875wyuqaj4.fsf@bootlin.com>
In-Reply-To: <875wyuqaj4.fsf@bootlin.com>

--1af248fcc003f2e9190f10866a1810a2857490b1df2b79d3d9fd96a2faf7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Oct 22, 2026 at 12:45 PM CEST, Miquel Raynal wrote:
> On 22/10/2026 at 03:26:12 -07, Changhuang Liang <changhuang.liang@starfiv=
etech.com> wrote:
>
>> Currently spi_nor_spimem_setup_op() sets all four phases (cmd, addr,
>> dummy, data) to DTR whenever spi_nor_protocol_is_dtr(proto) is true.
>> This is too coarse: the 1S-xD-xD DTR protocols (1_1_1_DTR, 1_2_2_DTR,
>> 1_4_4_DTR, 1_8_8_DTR) send the command phase in STR on a single line,
>> and only the address, dummy and data phases in DTR. SPIMEM supports
>> such mixed DTR modes.
>>
>> Split the handling:
>>
>>   - For SNOR_PROTO_8_8_8_DTR, keep the existing behavior: set all
>>     phases to DTR and use a 2-byte opcode (opcode + extension).
>>
>>   - For the other DTR protocols, set the command phase to STR and only
>>     the address, dummy and data phases to DTR. Double op->dummy.nbytes
>>     since DTR transfers 2 bytes per clock cycle, matching how the dummy
>>     cycle count is specified for these protocols.
>>
>> No in-tree flash currently declares SNOR_HWCAPS_READ_1_x_x_DTR, so
>> this is not a bug fix but preparation for enabling these protocols.
>> A follow-up patch will enable 1S-4D-4D for the MX66L1G45G. The
>> 8D-8D-8D path is unchanged.
>>
>> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>> ---
>>  drivers/mtd/spi-nor/core.c | 21 ++++++++++++++-------
>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 90524c58602e..43e506e728ab 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -97,13 +97,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *no=
r,
>>  	if (op->data.nbytes)
>>  		op->data.buswidth =3D spi_nor_get_protocol_data_nbits(proto);
>> =20
>> -	if (spi_nor_protocol_is_dtr(proto)) {
>> -		/*
>> -		 * SPIMEM supports mixed DTR modes, but right now we can only
>> -		 * have all phases either DTR or STR. IOW, SPIMEM can have
>> -		 * something like 4S-4D-4D, but SPI NOR can't. So, set all 4
>> -		 * phases to either DTR or STR.
>> -		 */
>> +	if (proto =3D=3D SNOR_PROTO_8_8_8_DTR) {
>>  		op->cmd.dtr =3D true;
>>  		op->addr.dtr =3D true;
>>  		op->dummy.dtr =3D true;
>> @@ -115,6 +109,19 @@ void spi_nor_spimem_setup_op(const struct spi_nor *=
nor,
>>  		ext =3D spi_nor_get_cmd_ext(nor, op);
>>  		op->cmd.opcode =3D (op->cmd.opcode << 8) | ext;
>>  		op->cmd.nbytes =3D 2;
>> +	} else if (spi_nor_protocol_is_dtr(proto)) {
>> +		/*
>> +		 * 1S-xD-xD protocols: the opcode is sent in STR on a single
>> +		 * line, only the address, dummy and data phases are DTR. The
>> +		 * opcode stays 1 byte (no command extension).
>> +		 */
>> +		op->cmd.dtr =3D false;
>> +		op->addr.dtr =3D true;
>> +		op->dummy.dtr =3D true;
>> +		op->data.dtr =3D true;
>
> Still to coarse IMHO.
>
> What about xS-xS-xD?

Is this a thing? Are there any NOR flashes which support the address
being SDR? That doesn't make much sense, does it? The command being
SDR makes sense because you don't have to switch modes and thus
you're stateless.

Also spi-nor.h only defines 1S-nD-nD (for n=3D2,4,8) for DTR. IIRC the
original DTR code was just for 8D-8D-8D because that is actually
backed by the xSPI standard.

Anyway, can we just have something like:


if (spi_nor_protocol_is_dtr(proto)) {
		/* we only support 1SnDnD or 8D8D8D */
		op->addr.dtr =3D true;
		op->dummy.dtr =3D true;
		op->data.dtr =3D true;

		/* 2 bytes per clock cycle in DTR mode. */
		op->dummy.nbytes *=3D 2;

		if (SNOR_PROTO_8_8_8_DTR) {
			op->cmd.dtr =3D true;
			ext =3D spi_nor_get_cmd_ext(nor, op);
			op->cmd.opcode =3D (op->cmd.opcode << 8) | ext;
			op->cmd.nbytes =3D 2;
		}
}

Also you missed the support for SNOR_F_SWAP16.

-michael

> As mentioned in the spi controller patch you must make sure these are
> refused if they are not supported by your controller because SPI NAND at
> least allow them (and I believe SPI NOR might as well)?.
>
>> +
>> +		/* 2 bytes per clock cycle in DTR mode. */
>> +		op->dummy.nbytes *=3D 2;
>>  	}
>> =20
>>  	if (proto =3D=3D SNOR_PROTO_8_8_8_DTR && params->flags & SNOR_F_SWAP16=
)


--1af248fcc003f2e9190f10866a1810a2857490b1df2b79d3d9fd96a2faf7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCatn/TxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gJUQF/eZexncx5GXCJ+FOCrW+m7fpS3XzSqDKU
AcWfX3qMUm2aBpDKs6ws8cyGLgs4SdOjAX4tS2EbAC7wDX8WqrUP/vrGB51OL+WB
vO4L1XOHK1vIOgc8v/f4uVVCz7f93KsxKSA=
=1d5h
-----END PGP SIGNATURE-----

--1af248fcc003f2e9190f10866a1810a2857490b1df2b79d3d9fd96a2faf7--
