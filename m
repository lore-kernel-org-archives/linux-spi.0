Received: from mta0.migadu.com (out-165.mta0.migadu.com [91.218.175.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3103B4D2ED5
	for <linux-spi@vger.kernel.org>; Fri, 18 Sep 2026 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789732393; cv=none; b=IWqd2+QX1lJ5guVhLVvA/NseZRIpaf6xWsAr1MmpESRkZVGL+7Hh2VPNhsz7hEphtYQCA5nG+ZHUcckjYtNa9Etc5jwUJ7USvk7fzaM3vuY0D+zZOtRiEYtgrhZNXAokwc82R2rcFVmBU/Mr1MMLVSmb0IzHPkbSuSdGBnDFHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789732393; c=relaxed/simple;
	bh=Us9LrP9tn+cuJ23nFB72OLu50wkifpY3Zpopv4/iL6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1tnKBdqQjomGMvOa/YdoTBfgwheiUhLyj8Wjvqyo/XVHe9a/U+Zcs+kwkshqmq+g7bC0Dbq5Gjg/s2OEC1CvGE44+/G9wkFT/E5q62bXrlDm6mvp0fIXqb290WPZPcpPeLMZVClD3nEHf6Juuhv7zQjCff0KQNWu91LLAIA+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jimenezcarrero.com; spf=pass smtp.mailfrom=jimenezcarrero.com; dkim=pass (2048-bit key) header.d=jimenezcarrero.com header.i=@jimenezcarrero.com header.b=d/f5oLl/; arc=none smtp.client-ip=91.218.175.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jimenezcarrero.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jimenezcarrero.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jimenezcarrero.com header.i=@jimenezcarrero.com header.b="d/f5oLl/"
X-Envelope-To: linux-spi@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Us9LrP9tn+cuJ23nFB72OLu50wkifpY3Zpopv4/iL6Y=;
 c=simple/simple; d=jimenezcarrero.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789732387; v=1; x=1790337187;
 b=d/f5oLl/SH336LyEBGAZxWL2G4XFl5CeATmwv/LL33SBRxdOil55kxUaJcrxiJ8lZB5xVx/2
 Ywm1zltLTipe4xxje7No+Q4L/V6dKSGS3ABQph+bQKWUQj4YBxq9dDXLCYT3SRqCkI+JalnN5+G
 5doz8fpnoerAYriWv9DA88JUqr7lmGd4Y9cgI1V/6Fvep9q7zCL3AbABd7EyRmNJpYQvGhROUiE
 KxzkFmxP22QQpFexXb5vw/3VOfjER0hRzqDjUvmGU/UObPsdk93f2OxiNOO+0OT3Glpn430On9y
 O69c622QDZtMhzEqZSSKDYqsnQH+w8UTLSCv6VULmZD7A==
X-Envelope-To: linux-spi@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4f71428dc03b4a63;
	Fri, 18 Sep 2026 11:52:57 +0000
X-Mizu-Trace-ID: 4f71428dc03b4a63
X-Migadu-Flow: FLOW_OUT
From: Juan Jimenez Carrero <juan@jimenezcarrero.com>
To: rf@opensource.cirrus.com,
	khalilst@gmail.com
Cc: khalil@rentman.nl,
	broonie@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	patches@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	daniel@zonque.org,
	haojian.zhuang@gmail.com,
	robert.jarzmik@free.fr
Subject: Re: [PATCH v3 0/3] Fix CS35L56 amplifier on Intel LPSS SPI with broken ACPI cs-gpios
Date: Fri, 18 Sep 2026 13:52:40 +0200
Message-ID: <20260918115240.29204-1-juan@jimenezcarrero.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <a15eae4d-d533-4280-986c-5de90d5fd2e4@opensource.cirrus.com>
References: <a15eae4d-d533-4280-986c-5de90d5fd2e4@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 14:42:18 +0100, Richard Fitzgerald wrote:
> The latest BIOS (01.06.02) is reported to fix the problem:
> https://bugzilla.kernel.org/show_bug.cgi?id=221064#c23

Thanks, Richard. Confirmed on the same machine as my earlier report:

  HP EliteBook 8 G1i 14 inch, DMI board 8D8A, SKU D75TQET#ABE
  BIOS X91 Ver. 01.05.02 -> X91 Ver. 01.06.02 (dated 07/22/2026)

I dumped the ACPI tables before and after the update. The only change
in Scope (\_SB.PC00.SPI0) is the cs-gpios property:

   "cs-gpios",
  -Package (0x01)
  +Package (0x05)
   {
  +    Zero,
  +    GSPK,
  +    Zero,
  +    Zero,
       Zero
   }

CS0 stays on the native chip select and CS1 becomes GpioIo resource 0
of GSPK, which is the same GPIO that 2/3 installs. Device (GSPK) is
unchanged between the two versions.

On 01.06.02 with an unpatched kernel (7.2.5, no out-of-tree modules,
taint 0) both amplifiers probe, the calibration is applied and the
speakers play. The "cs1 >= max 1" error is gone.

With 2/3 and 3/3 still loaded on 01.06.02, the quirk matches the DMI
entry but returns early because cs < num_chipselect, so the series
does no harm on the fixed firmware. On 01.05.02 it is still needed,
and my earlier Tested-by stands for that case.

One small detail in case there is a v4: the DMI entry's .ident says
"HP EliteBook 8 G1i 16 inch", but board 8D8A is also the 14 inch model
I tested on.

Thanks,
Juan
