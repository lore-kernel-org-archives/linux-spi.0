Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A81F91D6
	for <linux-spi@vger.kernel.org>; Sat, 28 Feb 2026 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293464; cv=none; b=kKO55YAg/d+sWdSZ/0NRJ4uEBw/u4ga+31/Fd1YOILhsraN256+Oq1378BsfR/JJUsIqxnWk4CQmm2T8D+JP83+FLj9euGb8sF8pfo9Q1XNoThlyeRD9OsU94sfb/tRkCC6rEwIIAJSODrq9U2foQbfWQ1LwxxKDULTjNJwmFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293464; c=relaxed/simple;
	bh=5Qw+edcU7eQ+IhNJYGlJrYssgzL09msX+Nv4/79BZwc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zxbs0QIi2iZWt0C25B18XPTbEcTk0NEkCMJ1fdQmHC7KicMpSPivPLmT6UQJwhJd3RUfxGygSxsc8Aah8lwaZiHdgYzNi1ge6V369uFOIhaCWibvciCebX25/k5z5nxN2e7oZW8whnjqnUBijTpL0U/fkMp8BTO3lN6NPZL80gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=localtargetshows.com; spf=pass smtp.mailfrom=localtargetshows.com; dkim=pass (2048-bit key) header.d=localtargetshows-com.20230601.gappssmtp.com header.i=@localtargetshows-com.20230601.gappssmtp.com header.b=t/A5SUO4; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=localtargetshows.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=localtargetshows.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=localtargetshows-com.20230601.gappssmtp.com header.i=@localtargetshows-com.20230601.gappssmtp.com header.b="t/A5SUO4"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c70bc5b4e86so1222023a12.0
        for <linux-spi@vger.kernel.org>; Sat, 28 Feb 2026 07:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=localtargetshows-com.20230601.gappssmtp.com; s=20230601; t=1772293462; x=1772898262; darn=vger.kernel.org;
        h=content-language:thread-index:mime-version:message-id:date:subject
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k4rqFROlmDzK0rhFpwa7fWO+ypiKmg+IJdGCeoKonEo=;
        b=t/A5SUO4mRNh70u7vC8jfJdCF190ysp6MpvtHOUXigcvhhjsIrAisCAsuWiEUW24Kk
         mqIjReuvz+FLoPBZle+4UEC6/3nG5rF2ud4SGYLjt337YLOyOhiU2eSWD3mWTamuLM44
         heh5m+iZxa2MjtyepzbnVUn1Rs6bpvfVVGxtOjSODtkZrxoYZbdoCjrn6Rc5b8axi7Fq
         KMcr2vpuEZ4ESv5a56eLY/2TVK7t9pPq1v29GKdZA7U/otQRKr9C6jaeTU7lfs/97bNk
         BQveui+Uam86LS06XHe2XIJEjR14ZfOOh6/i8qs+rCIhkT240l6ydY/H5WL7+X7UqMMq
         /u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772293462; x=1772898262;
        h=content-language:thread-index:mime-version:message-id:date:subject
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4rqFROlmDzK0rhFpwa7fWO+ypiKmg+IJdGCeoKonEo=;
        b=nOtxz1TbRHMXjZ63QC3NuotPtpg03nl/W/ysVt3qUYjC7EEgpUV45fSdnE62L/6vvA
         bQ3McGlrfv7r/210DgcsBylh7vi0437LuDt6TQGCdBQ5wCQ23vwnk6BBbmZ5bOpunHTS
         NwFU92IgcWbXQQF+JU2ydDeH1hwWfP+tVRz46JN99QD+IBzyps4YsA9jB7fGNC2OpbCm
         FomX32UjzEjiTpDD482u7zf7drnCOLPpvCIb3G/GHwSyfRDGKGq/ztWmEExHGuzHSUWV
         amZGXZW+OBS7ous7OACbOw8o3bWkRg6f0OLaIfJyYGVobY7aY9k78yzf5zgBAFQZmyPS
         oU/Q==
X-Gm-Message-State: AOJu0Yw01kTnaObQyO7DNBu+tlIs8yg2S3fbAEootr35ZP1HFrWu8X3W
	yeKwATGZmMNB3ilGGzgXsH+PHbQCT6idQxb3Y/YOl8upPstt0JLPUTAidD1yf5zDMYrC3u/4+Vy
	QXaW6Nz8=
X-Gm-Gg: ATEYQzwDq42KLo8IuLYy6eygecH/8hJ2RRe6+J7I9fWrw9PNiZ0EVBDlGqVlfEt+/XV
	VQtNbdyEadmZU8e4tNoPV7MOys+RTLNv24Mdfs3nNYuAako3bkPIAx+W4eT3emLkll/eDKKG93/
	xM78GHxe2K8KPoFWhN9Y0btw1dcYeN0gNimkY/DdOZPDJjxh5LD24uBmQ6QrHLRBfJeZLdCt+7Y
	QDpUp2x0G2M7t2curdy6UId9B7WfZP0H1dIcxRyDEDBbkiCOXbgqv0fXei1iMCAtPdQXotrGFfc
	rUAIN6DD058kM+6Vu8U3N/ar5zb84Vi9gySosBGRHR/tYKB5Bg2sBUlXxl/1V1NOYtkxMV0hFds
	9L/7xiAfXnmYD2z5VI+uJMSnQ2qFDNU0wg/f1SiFcfd05imGLmYyYFiDgUUIDylGJGbrW56jlrR
	Pu5sKoVLektciYa9UaiEjUekHuyzpfHj6kw77ayYunOekNsJtjibDZgQ==
X-Received: by 2002:a05:6a21:689:b0:394:f972:43c3 with SMTP id adf61e73a8af0-395c3b3ac5amr6347748637.63.1772293461693;
        Sat, 28 Feb 2026 07:44:21 -0800 (PST)
Received: from DESKTOPO5PKTIC ([2406:7400:11d:7944:b022:eb99:128b:bc27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa8479aasm7725337a12.31.2026.02.28.07.44.18
        for <linux-spi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Feb 2026 07:44:19 -0800 (PST)
From: "Caitlyn Christensen" <cchristensen@localtargetshows.com>
To: <linux-spi@vger.kernel.org>
Subject: OFC Conference 2026 - Vger.Kernel
Date: Sat, 28 Feb 2026 10:44:15 -0500
Message-ID: <157201dca8c9$1a299d60$4e7cd820$@localtargetshows.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_1573_01DCA89F.31539560"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdyoyRZjshDwJA11Tjyzb7zM1OmEKQ==
Content-Language: en-in
X-MS-TNEF-Correlator: 00000000B48EE13E633F4E45B250D8DCD108A12D448A5700

This is a multipart message in MIME format.

------=_NextPart_000_1573_01DCA89F.31539560
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

Would you be interested in acquiring the attendee email database for the
Optical Fiber Communication (OFC) Conference 2026?

 

Attendees include: Fiber Optic Engineers, Optical Network Architects,
Telecom Network Engineers, Photonics Researchers, RF Engineers, Optical
Systems Designers, Network Infrastructure Managers, Data Transmission
Specialists, R&D Scientists, Product Development Engineers, Technical
Directors, VPs of Engineering, CTOs, Telecom Consultants, System
Integrators, Optical Component Manufacturers, Communication Technology
Professionals, and other leading industry experts.

 

Please let me know if you are interested, and I will share the total number
of attendees along with the pricing details for your review.

 

Best regards,

Caitlyn Christensen

Trade Show & Events Data Specialist

 

Note: If you are also interested in upcoming event lists or targeted
industry email/user databases, please feel free to let me know. I would be
happy to assist you in finding the right data for your business needs.


------=_NextPart_000_1573_01DCA89F.31539560
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

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
IJvSmCEFwP0ZUHYIkCpg7//xD/If8y//9D/1T/Zf92/4f/mP7O/t///vDwNvBH8FjwafB68QbwnP
vwrfC+8M/w4Pvj8bKEKY4fcCwU4gTwBzwQ/CHxtVfz//Ef8TDxQfFS8WPxdPGF8Zb/8afyeSOcA2
sF1gmVBhQJnA/5jxzxChgCHfIu8j/yUPJh//Jy8oPylPKl8rb3thzuEBwL/TQMiQ+9AOH9GvwxdF
1LD/2fHOhM+4Ld8u7y//MQ8yH/8zLzQ/NU82XzdvG58O/xAP/z2PPp8/r0C/Qc9Kj0PvRP/HRg9H
H0sMMTQ4TBBY4ud11lzTZqMxMWeid5FUr3d7YVQgxmA6zPD8CN/Bb/mYjXVw2TGZ0tSh1SHQE3/X
gJvxaKEB0JkT4Vaa8i/v4WDD0ZtGxOFw+tShUMbg75vAoXD+kvsqLv2Sl9OYYfn+IHBw3wBhgXkx
0CH8E92ZQWbhMZnWmcBnOsCbM/0COGLhYMSRU8D/AJqwHxD/Az9MH00sVex0cG/CVxEgb79Vk04P
Tx9QL1E/am4waIHOL3jRa/9wH2c1VtEgQHXUMHlo7jcgITrCUkB9AXeAAAAAAwAWEAMAAAADAA00
/T+lDgMADzT9P6UOAgEUNAEAAAAQAAAATklUQfm/uAEAqgA32W4AAAIBfwABAAAAMQAAADAwMDAw
MDAwQjQ4RUUxM0U2MzNGNEU0NUIyNTBEOERDRDEwOEExMkQ0NDhBNTcwMAAAAAADAAYQvQtbowMA
BxBpAwAAAwAQEAAAAAADABEQAQAAAB4ACBABAAAAZQAAAEhJLFdPVUxEWU9VQkVJTlRFUkVTVEVE
SU5BQ1FVSVJJTkdUSEVBVFRFTkRFRUVNQUlMREFUQUJBU0VGT1JUSEVPUFRJQ0FMRklCRVJDT01N
VU5JQ0FUSU9OKE9GQylDT05GRVIAAAAA/Dw=

------=_NextPart_000_1573_01DCA89F.31539560--

